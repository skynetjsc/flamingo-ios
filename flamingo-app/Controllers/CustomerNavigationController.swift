//
//  CustomerNavigationController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/1/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import SideMenuSwift

class CustomerNavigationController: UINavigationController, UITabBarControllerDelegate {

    @objc func backNav(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
        //            self.present(newViewController, animated: true, completion: nil)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = newViewController
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backNav(_:)))
        self.navigationItem.leftBarButtonItem = newBackButton
//
//        
//        
//        print("success")
//        let tabBarController = ESTabBarController()
//        tabBarController.delegate = self
//        tabBarController.title = "Irregularity"
//        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
//        tabBarController.tabBar.backgroundImage = UIImage(named: "background_dark")
//        tabBarController.shouldHijackHandler = {
//            tabbarController, viewController, index in
//            if index == 2 {
//                return true
//            }
//            return false
//        }
//        tabBarController.didHijackHandler = {
//            [weak tabBarController] tabbarController, viewController, index in
//            
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
//        }
//        
//        let v1 = CustomerHomeViewController()
//        let v2 = CustomerHomeViewController()
//        let v3 = CustomerHomeViewController()
//        let v4 = CustomerHomeViewController()
//        let v5 = CustomerHomeViewController()
//        
//        v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
//        v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
//        v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "photo_verybig"), selectedImage: UIImage(named: "photo_verybig"))
//        v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
//        v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "Me", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
//        
//        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
//
//        let navigationController = CustomerNavigationController.init(rootViewController: tabBarController)
//        tabBarController.title = "Example"
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

}
