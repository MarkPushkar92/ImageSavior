//
//  PasswordCreator.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 23.12.2021.
//

import Foundation

class PasswordCreator {
    
    private var password : String?
    
    func setPassword(password : String) {
        self.password = password
    }
    
    func checkPassword(password : String) -> Bool {
        if let currentPassword = self.password {
            if password == currentPassword {
                return true
            }
        }
        
        return false
    }
    
    func reset()
    {
        self.password = nil
    }
}
