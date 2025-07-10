//
//  MainTabBarController.swift
//  payapp
//
//  Created by Georgy on 2025-07-09.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let liveVC = SelectProfileHomeScreen()
        liveVC.tabBarItem = UITabBarItem(title: "tabbar.live".localized,
                                         image: UIImage(named: "live"),
                                         selectedImage: nil)
        
        let feedVC = SelectProfileHomeScreen()
        feedVC.tabBarItem = UITabBarItem(title: "tabbar.feed".localized,
                                         image: UIImage(named: "feed"),
                                         selectedImage: nil)
        
        let chatVC = SelectProfileHomeScreen()
        chatVC.tabBarItem = UITabBarItem(title: "tabbar.chat".localized,
                                         image: UIImage(named: "chat"),
                                         selectedImage: nil)
        
        let profileVC = SelectProfileHomeScreen()
        profileVC.tabBarItem = UITabBarItem(title: "tabbar.profile".localized,
                                            image: UIImage(named: "profile"),
                                            selectedImage: nil)
        
        viewControllers = [liveVC, feedVC, chatVC, profileVC]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor(white: 0.8, alpha: 1)
    }
}
