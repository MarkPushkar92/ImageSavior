//
//  LogInWithFaceOrTochIDController.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 18.04.2022.
//

import Foundation
import LocalAuthentication
import UIKit

class LogInWithFaceOrTochIDController: UIViewController {
    
    private func getTitleForButton() -> String {
        return LocalAuthorizationService.shared.getBiometricType().rawValue
    }

    private func handleAuthorizationFailure() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Failed to Log In", message: "Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
    
    private func handleAuthorizationSuccessfully() {
        DispatchQueue.main.async { [weak self] in
            let vc = TabBarViewController()
            self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
    
    @objc private func authorizeClicked() {
        LocalAuthorizationService.shared.authorizeIfPossible { [weak self] status in
            if status {
                self?.handleAuthorizationSuccessfully()
            } else {
                self?.handleAuthorizationFailure()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame : CGRect(x: 0, y: 0, width: 100, height : 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle(self.getTitleForButton(), for: .normal)
        button.backgroundColor = .systemIndigo
        button.addTarget(self, action: #selector(authorizeClicked), for: .touchUpInside)
    }
}

