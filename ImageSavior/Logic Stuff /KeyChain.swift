//
//  KeyChain.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 25.12.2021.
//

import Foundation
import KeychainAccess

class AppKeychain {
    private static let keychain = Keychain(service: AppCommonSettings.keychainServiceName)
    
    public static func savePassword(password : String) {
        AppKeychain.keychain[AppCommonSettings.keychainAppPasswordKey] = password
    }
    
    public static func getPassword() -> String? {
        if let password = try? AppKeychain.keychain.getString(AppCommonSettings.keychainAppPasswordKey) {
            return password
        } else {
            return nil
        }
    }
}

enum AppCommonSettings {
    static let keychainServiceName : String = "FolderContentViewerService"
    static let keychainAppPasswordKey : String = "app_password"
}
