//
//  ChangePasswordViewController.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 26.12.2021.
//

import Foundation
import UIKit

class ChangePasswordViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        createView()
     }

    private let popUpTitle : UILabel = {
        let view = UILabel()
        view.text = "Enter new password"
        view.numberOfLines = 1
        view.textColor = UIColor.black
        view.font = .systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .center
        return view
    }()
    
    private let passwordTextField: UITextField = {
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

    @objc private func applyButtonClickHandler() {
        if let passwordFromUser = passwordTextField.text {
            if passwordFromUser.count >= 4 {
                AppKeychain.savePassword(password: passwordFromUser)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
        
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(applyButtonClickHandler), for: .touchUpInside)
        button.backgroundColor = .darkGray
        return button
     }()


     private func createView() {

     
         self.view.addSubview(popUpTitle)
         self.view.addSubview(passwordTextField)
         self.view.addSubview(applyButton)
         
         
         let constraints = [
            popUpTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            popUpTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            popUpTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            passwordTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50),
            
            applyButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            applyButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: 25),
            applyButton.heightAnchor.constraint(equalToConstant: 20),
            applyButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor)
         ]
         
         NSLayoutConstraint.activate(constraints)
     }}
