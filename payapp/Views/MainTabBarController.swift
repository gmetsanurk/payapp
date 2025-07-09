//
//  MainTabBarController.swift
//  payapp
//
//  Created by Georgy on 2025-07-09.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let liveVC = SelectProfileHomeScreen()
        liveVC.tabBarItem = UITabBarItem(title: "Live",
                                         image: UIImage(named: "live"),
                                         selectedImage: nil)
        
        let feedVC = SelectProfileHomeScreen()
        feedVC.tabBarItem = UITabBarItem(title: "Feed",
                                         image: UIImage(named: "feed"),
                                         selectedImage: nil)
        
        let chatVC = SelectProfileHomeScreen()
        chatVC.tabBarItem = UITabBarItem(title: "Chat",
                                         image: UIImage(named: "chat"),
                                         selectedImage: nil)
        
        let profileVC = SelectProfileHomeScreen()
        profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: UIImage(named: "profile"),
                                            selectedImage: nil)
        
        viewControllers = [liveVC, feedVC, chatVC, profileVC]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor(white: 0.8, alpha: 1)
    }
}
