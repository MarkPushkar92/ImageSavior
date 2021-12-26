//
//  LogInViewController.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 13.12.2021.
//

import UIKit

class LogInViewController: UIViewController {

    
//MARK: Properties
    
    private var kCPassword : String?
    
    private let passwordCreator = PasswordCreator()
    
    private var loginStage : LoginStage = .initialState {
        didSet {
            if oldValue == .initialState && loginStage == .createPasswordStepOne  {
                setLoginButtonTitle(title: "Create password")
            } else if oldValue == .initialState && loginStage == .checkExistingPassword  {
                setLoginButtonTitle(title: "Type password")
            } else if oldValue == .createPasswordStepOne && loginStage == .createPasswordStepTwo {
                setLoginButtonTitle(title: "Retype password")
            }
        }
    }
    
//MARK: Private Methods
    
    private func setLoginButtonTitle(title : String) {
        if let view = self.view as? LogInView {
            view.setLoginButtonTitle(title: title)
        }
    }
    
    private func createPasswordStepOne(password : String) {
        if password.count < 4 {
            let alert = UIAlertController(title: "Not Suitable Password", message: "Min password length is 4 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            passwordCreator.setPassword(password: password)
            loginStage = .createPasswordStepTwo
        }
    }
    
    private func createPasswordStepTwo(password : String) {
        loginStage = .initialState
        
        if passwordCreator.checkPassword(password: password) {
            buttonTapped() 
            AppKeychain.savePassword(password: password)
            kCPassword = password
        } else {
            let alert = UIAlertController(title: "Error", message: "Password mismatch", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        passwordCreator.reset()
        currentLoginState()
    }
    
    private func checkExistingPassword(password : String) {
        loginStage = .initialState
        
        if passwordCreator.checkPassword(password: password) {
            buttonTapped()
        } else {
            let alert = UIAlertController(title: "Error", message: "Password mismatch", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        passwordCreator.reset()
        currentLoginState()
    }
    
    private func handleLoginClickEvent(data : String) {
        switch loginStage {
        case .initialState:
            ()
        case .createPasswordStepOne:
            createPasswordStepOne(password: data)
        case .createPasswordStepTwo:
            createPasswordStepTwo(password: data)
        case .checkExistingPassword:
            checkExistingPassword(password: data)
        }
    }
    
    private func currentLoginState() {
        if let password = kCPassword {
            self.loginStage = .checkExistingPassword
            passwordCreator.setPassword(password: password)
        } else {
            self.loginStage = .createPasswordStepOne
        }
    }
    
    private func initializeViewBasedOnKeychainContent() {
        if let keychainPassword = AppKeychain.getPassword() {
            self.loginStage = .checkExistingPassword
            passwordCreator.setPassword(password: keychainPassword)
            kCPassword = keychainPassword
        } else {
            self.loginStage = .createPasswordStepOne
        }
    }
    
//MARK: LogIn Func
    
    func buttonTapped() {
        print("Go to ... ")
        let tabBar = TabBarViewController()
        present(tabBar, animated: true, completion: nil)
    }
        
//MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInView = LogInView(viewFrame: self.view.frame)
        logInView.logInFunc = { [weak self] password in
            guard let this = self else {
                return
            }
            
            this.handleLoginClickEvent(data : password)
        }
        view = logInView
        initializeViewBasedOnKeychainContent()
    }
}

