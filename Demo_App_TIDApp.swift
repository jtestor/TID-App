//
//  Demo_App_TIDApp.swift
//  Demo App TID
//
//  Created by Miguel Testor on 19-05-25.
//

import SwiftUI
import SwiftyRSA
@main
struct Demo_App_TIDApp: App {

    private let healthManager = HealthManager()
    private let iotClient: IoTClient

    init() {
        print("App inicializada (antes de KeyManager)")
        KeyManager.generateKeyPairIfNeeded()
        

      

        iotClient = IoTClient(manager: healthManager)
        print(" IoTClient creado")
        
        if AESKeyManager.shared.hasKey == false {
            iotClient.startHandshake()
        } else {
            print("Ya existe AES Key, no se realiza handshake")
            iotClient.fetchTelemetry()
        }
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(healthManager)
        }
    }
}
