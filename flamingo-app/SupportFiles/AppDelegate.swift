//
//  AppDelegate.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/17/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift
//import FBSDKShareKit
import FBSDKLoginKit
//import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if DEBUG
        var arguments = ProcessInfo.processInfo.arguments
        arguments.removeFirst()
        setupTestingEnvironment(with: arguments)
        #endif

        configureSideMenu()

        GIDSignIn.sharedInstance().clientID = "474747087001-bp597lmputsspte60uo6m1o1mksts2ts.apps.googleusercontent.com"
        print(App.shared.getStringAnyObject(key: K_CURRENT_USER))
        let token = App.shared.getStringAnyObject(key: K_CURRENT_USER)
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if token["access_token"] != nil{

//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
////            self.present(newViewController, animated: true, completion: nil)
//            self.window?.rootViewController = newViewController
            if userInfo["ID"] != nil {
                let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
                let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
                let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
                self.window?.rootViewController = sideMenuController
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                // instantiate your desired ViewController
                let rootController = storyboard.instantiateViewController(withIdentifier: "LoginNavigation") as! UINavigationController
                
                self.window?.rootViewController = rootController
            }
            
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // instantiate your desired ViewController
            let rootController = storyboard.instantiateViewController(withIdentifier: "LoginNavigation") as! UINavigationController
            
            self.window?.rootViewController = rootController
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func configureSideMenu() {
        SideMenuController.preferences.basic.menuWidth = 240
        SideMenuController.preferences.basic.defaultCacheKey = "0"
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url as URL?,
//                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let str_URL = url.absoluteString as NSString
        if str_URL.contains("323411274838379"){

            return ApplicationDelegate.shared.application(
            app,
            open: (url as URL?)!,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]) || GIDSignIn.sharedInstance().handle(url as URL?,
                                                                                                                  sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                                                                                  annotation: options[UIApplication.OpenURLOptionsKey.annotation])

        }


        return ApplicationDelegate.shared.application(
        app,
        open: (url as URL?)!,
        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
        annotation: options[UIApplication.OpenURLOptionsKey.annotation])

    }


}

#if DEBUG
extension AppDelegate {
    private func setupTestingEnvironment(with arguments: [String]) {
        if arguments.contains("SwitchToRight") {
            SideMenuController.preferences.basic.direction = .right
        }
    }
}
#endif


extension UIApplication {
    var statusBarView : UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
