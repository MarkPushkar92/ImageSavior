//
//  SettingsViewController.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 13.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
//MARK: Funcs

    public var initialViewSetup : SettingsViewSetup?
    
    private func setupView() {
        let view = SettingsView(viewFrame: self.view.frame)
        view.passwordChangeHandler = { [weak self] in
            guard let this = self else {
                return
            }

            let vc = ChangePasswordViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve

            this.present(vc, animated: true, completion: nil)
        }

        self.view = view
    }
    
    private func applyUserDefaultsSettings() {
        guard let viewSetup = initialViewSetup,
              let view = self.view as? SettingsView
        else {
            return
        }
        
        view.sortingEnabled = viewSetup.isSortingEnabled
        view.ascendingOrder = viewSetup.isAscendingMode
    }
    
    public func getCurrentViewSettings() -> SettingsViewSetup? {
        if let view = self.view as? SettingsView {
            let setup = SettingsViewSetup(isSortingEnabled: view.sortingEnabled,
                                          isAscendingMode: view.ascendingOrder
            )
            
            return setup
        } else {
            return nil
        }
    }
    
    private func saveViewSettings() {
        if let view = self.view as? SettingsView {
            let setup = SettingsViewSetup(isSortingEnabled: view.sortingEnabled,
                                          isAscendingMode: view.ascendingOrder
            )
            
            AppUserDefaults.saveSettingsViewSetup(setup: setup)
        }
    }
    
//MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        setupView()
        
        applyUserDefaultsSettings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveViewSettings()
    }
}

