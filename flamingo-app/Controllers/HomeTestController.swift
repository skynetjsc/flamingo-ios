//
//  HomeTestController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/21/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class HomeTestController: MainTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
}

class MainTabBarController: UITabBarController {
    
    override func viewWillLayoutSubviews() {
        var newTabBarFrame = tabBar.frame
        
//        let newTabBarHeight: CGFloat = 200
//        newTabBarFrame.size.height = newTabBarHeight
//        newTabBarFrame.origin.y = self.view.frame.size.height - newTabBarHeight
////        newTabBarFrame. = UIEdgeInsetsMake(0, 25, 25, 25)
//        tabBar.frame.insetBy(dx: -25, dy: -15)
//        tabBar.frame = newTabBarFrame
        
    }
}
