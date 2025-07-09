//
//  KeychainHelper.swift
//  Demo App TID
//
//  Created by Miguel Testor on 08-07-25.
//

import Foundation
import Security

enum KeychainHelper {
    static func save(key: String, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass              as String: kSecClassGenericPassword,
            kSecAttrAccount        as String: key,
            kSecValueData          as String: data,
            kSecAttrAccessible     as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]

        SecItemDelete(query as CFDictionary) // Borra si existe
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    static func load(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass               as String: kSecClassGenericPassword,
            kSecAttrAccount         as String: key,
            kSecReturnData          as String: true,
            kSecMatchLimit          as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else { return nil }
        return item as? Data
    }

    static func delete(key: String) {
        let query: [String: Any] = [
            kSecClass      as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
