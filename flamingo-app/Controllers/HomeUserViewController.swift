//
//  HomeUserViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift

class HomeUserViewController: BaseViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var role: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setName()
       
        let offset = 1
        let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        //        let navigationcolor = UIColor.init(hue: 0, saturation: CGFloat(offset), brightness: 1, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    func setName() {
        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
        
        var fName = userInfo["FirstName"]!
        var firstName = String(describing: fName)
        if firstName.elementsEqual("<null>") || firstName.elementsEqual("") {
            firstName = ""
        }
        
        var lName = userInfo["LastName"]!
        var lastName = String(describing: lName)
        if lastName.elementsEqual("<null>") || lastName.elementsEqual("") {
            lastName = ""
        }
        
        var mName = userInfo["MiddleName"]!
        var middleName = String(describing: mName)
        if middleName.elementsEqual("<null>") || middleName.elementsEqual("") {
            middleName = ""
        }
        
        if !firstName.elementsEqual("") {
            self.name.text = "\(firstName) \(middleName) \(lastName)"
        } else {
            self.name.text = ""
        }
    }
    
    @IBAction func goToCustomer(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showCustomer", sender: nil)
    }
    
    @IBAction func goToTerm(_ sender: Any) {
        self.performSegue(withIdentifier: "goToTerm", sender: nil)
    }
    
    @IBAction func goToManagerPoint(_ sender: Any) {
        self.performSegue(withIdentifier: "showUserDetail", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCustomer" {
//            if let viewController: DetailNotificationController = segue.destination as? DetailNotificationController {
//                viewController.dataTitle = self.dataTitle!
//                viewController.dataContent = self.dataContent!
//            }
        }
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let offset = 1
        let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        //        let navigationcolor = UIColor.init(hue: 0, saturation: CGFloat(offset), brightness: 1, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    
    
    @IBAction func logOut(_ sender: Any) {
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()

        App.shared.remove(key: K_CURRENT_USER)
        App.shared.remove(key: K_CURRENT_USER_INFO)
        App.shared.remove(key: "USER_INFO")
        
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        // instantiate your desired ViewController
//        let rootController = storyboard.instantiateViewController(withIdentifier: "LoginNavigation") as! UINavigationController
//
//        UIApplication.shared.keyWindow?.rootViewController = rootController
        
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
    }
    
    @IBAction func changePassword(_ sender: Any) {
        self.performSegue(withIdentifier: "showOptionSecur", sender: nil)
    }
    
}
