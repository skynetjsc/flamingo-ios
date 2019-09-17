//
//  ExampleProvider.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/9.
//  Copyright © 2018年 Egg Swift. All rights reserved.
//

import UIKit
import ESTabBarController_swift

enum ExampleProvider {
    
    static func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> CustomerNavigationController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = ""
        tabBarController.navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(CustomerNavigationController.backNav(_:)))
        tabBarController.navigationItem.leftBarButtonItem = newBackButton
        
        
        
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.tabBar.backgroundImage = UIImage(named: "background_dark")
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
//                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
//                alertController.addAction(takePhotoAction)
//                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
//                alertController.addAction(selectFromAlbumAction)
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                alertController.addAction(cancelAction)
//                tabBarController?.present(alertController, animated: true, completion: nil)
//            }
        }

        let v1 = CustomerHomeViewController()
//        let v2 = CustomerPromotionViewController()
//        let v3 = CustomerNotificationViewController()
//        let v4 = CustomerNotificationViewController()
//        let v5 = CustomerUserViewController()
        
        v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "TRANG CHỦ", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
//        v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "ƯU ĐÃI", image: UIImage(named: "coupon"), selectedImage: UIImage(named: "coupon"))
//        v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: "", image: UIImage(named: "photo_verybig"), selectedImage: UIImage(named: "photo_verybig"))
//        v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "THÔNG BÁO", image: UIImage(named: "notification"), selectedImage: UIImage(named: "notification"))
//        v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "TÀI KHOẢN", image: UIImage(named: "user"), selectedImage: UIImage(named: "user"))
        
//        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
        let navigationController = CustomerNavigationController.init(rootViewController: tabBarController)
        
        return navigationController
    }
    

}
