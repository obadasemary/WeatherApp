//
//  MainTabController.swift
//  Loyalty
//
//  Created by Hasan Serdar on 29.05.2018.
//  Copyright © 2018 Abdelrahman Mohamed. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class MainTabController: UITabBarController {
    override func viewDidLoad() {
        tabBar.tintColor = UIColor("#7444C1")
        for item in viewControllers! {
            item.tabBarItem.title = nil
            item.tabBarItem.imageInsets = UIEdgeInsetsMake(-4, 0, -18, 0)
        }
    }
}
