//
//  KeychainHelper.swift
//  ShuntSense0
//
//  Created by Bhavna Malladi on 6/16/25.
//


// 📁 Step 1: Add this as KeychainHelper.swift (new file)

import Foundation
import Security

struct KeychainHelper {
    static func save(_ service: String, account: String, password: String) {
        if let data = password.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecValueData as String: data
            ]

            SecItemDelete(query as CFDictionary) // Overwrite existing
            SecItemAdd(query as CFDictionary, nil)
        }
    }

    static func read(_ service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &result) == noErr {
            if let data = result as? Data, let password = String(data: data, encoding: .utf8) {
                return password
            }
        }
        return nil
    }

    static func delete(_ service: String, account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
