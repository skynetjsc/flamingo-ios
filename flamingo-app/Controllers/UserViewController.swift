//
//  UserViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var codeShare: UILabel!
    
    @IBOutlet weak var viewLogout: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "THÔNG TIN TÀI KHOẢN"
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logout(_:)))
//        viewLogout.isUserInteractionEnabled = true
//        viewLogout.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
        print(userInfo)
        let valPoint = userInfo["Point"]!
        var point = String(describing: valPoint)
        if point.elementsEqual("<null>") || point.elementsEqual("") {
            point = "0"
        }
        
        let valPhone = userInfo["Telephone"]!
        let phone = String(describing: valPhone)
        
        if !phone.elementsEqual("<null>") && !phone.elementsEqual("") {
            
            self.phone.text = phone
            self.codeShare.text = phone
        }
        
        
        self.point.text = Int(point)?.formattedWithSeparator
        
    }
    
    @IBAction func changePassword(_ sender: Any) {
        self.performSegue(withIdentifier: "showOptionSecur", sender: nil)
    }
    @IBAction func goToSecurity(_ sender: Any) {
        
    }
    
    @IBAction func logout(_ sender: Any) {
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
        
        App.shared.remove(key: K_CURRENT_USER)
        App.shared.remove(key: "USER_INFO")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // instantiate your desired ViewController
        let rootController = storyboard.instantiateViewController(withIdentifier: "LoginNavigation") as! UINavigationController
        
        UIApplication.shared.keyWindow?.rootViewController = rootController
    }
    
}
