//
//  LogInView.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 14.12.2021.
//

import Foundation
import UIKit

typealias LogInFunc = (String) -> Void

class LogInView: UIView {
    
    var logInFunc: LogInFunc?
    
//MARK: LOGINFUNC
        
    @objc func buttonTapped() {
        logInFunc?(self.passwordTextField.text ?? "")
        self.passwordTextField.text = ""
    }
    
    func setLoginButtonTitle(title : String) {
        logInButton.setTitle(title, for: .normal)
    }
    
//MARK: Views and SetUp
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "  Password"
        password.translatesAutoresizingMaskIntoConstraints = false
        password.backgroundColor = .systemGray6
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.layer.cornerRadius = 10
        password.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        password.isSecureTextEntry = false
        password.textColor = .black
        password.font = .systemFont(ofSize: 16)
        return password
    }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = .darkGray
        return button
     }()
    
    private func setupViews(){
        self.backgroundColor = .lightGray
        addSubview(logInButton)
        addSubview(passwordTextField)
        let constraints = [
            
            passwordTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            
            logInButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            logInButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: 25),
            logInButton.heightAnchor.constraint(equalToConstant: 20),
            logInButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor)
      
        ]
        NSLayoutConstraint.activate(constraints)
     
    }
    
    init(viewFrame : CGRect) {
        super.init(frame: viewFrame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for LoginView")
    }
    
}
