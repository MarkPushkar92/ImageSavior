//
//  TabBarViewController.swift
//  ImageSavior
//
//  Created by Марк Пушкарь on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    let contents = ContentsViewController()
    let settings = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let contentsNav = configureContents()
        let settingsNav = configureSettings()
        self.viewControllers = [contentsNav, settingsNav]
        
        let userDefaultsSetup = AppUserDefaults.getSettingsViewSetup()
        settings.initialViewSetup = userDefaultsSetup
        contents.currentSettingsViewSetup = userDefaultsSetup
        let setup = settings.getCurrentViewSettings()
        contents.applySettingsViewSetup(setup: setup)
     }
    
    private func configureContents() -> UINavigationController {
      //  let contents = ContentsViewController()
        let navigationFirst = UINavigationController(rootViewController: contents)
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Contents",
            image: UIImage.init(systemName: "house.fill"), tag: 0)
        return navigationFirst
    }
    
    private func configureSettings() -> UINavigationController {
     //   let settings = SettingsViewController()
        let navigationFirst = UINavigationController(rootViewController: settings)
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage.init(systemName: "gear"), tag: 0)
        return navigationFirst
    }
    

}
