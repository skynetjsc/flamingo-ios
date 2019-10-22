//
//  SettingViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/2/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView
import SideMenuSwift

class SettingViewController: UIViewController {

    
    @IBOutlet var viewParent: UIView!
    @IBOutlet weak var blurMenu: VisualEffectView!
    @IBOutlet var menuView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    @IBAction func showMenuLeft(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    @IBAction func home(_ sender: Any) {
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
        
    }
    
    
    @IBAction func favorite(_ sender: Any) {
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteContentNavigation")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
        
    }
    @IBAction func card(_ sender: Any) {
        self.performSegue(withIdentifier: "showCard", sender: nil)
    }
    
    func setupMenu(_ menuView: UIView) {
        let backgroundView = viewParent!
        menuView.frame = CGRect(x: 0, y: self.viewParent.frame.size.height-80, width: self.viewParent.frame.size.width, height: 135)
        self.blurMenu.colorTintAlpha = 0.2
        self.blurMenu.blurRadius = 2.8
        self.blurMenu.scale = 1
        self.blurMenu.clipsToBounds = true
        
        backgroundView.addSubview(menuView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupMenu(menuView)
    }
    
    
    @IBAction func logout(_ sender: Any) {
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()

        App.shared.remove(key: K_CURRENT_USER)
        App.shared.remove(key: K_CURRENT_USER_INFO)
        App.shared.remove(key: "USER_INFO")
        
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        // instantiate your desired ViewController
//        let rootController = storyboard.instantiateViewController(withIdentifier: "LoginNavigation") as! UINavigationController
//
//        UIApplication.shared.keyWindow?.rootViewController = rootController
    }
    
    
    @IBAction func showRule(_ sender: Any) {
        self.performSegue(withIdentifier: "showRule", sender: nil)
    }
    
    @IBAction func showSecurity(_ sender: Any) {
        self.performSegue(withIdentifier: "showSecurity", sender: nil)
    }
    
}
