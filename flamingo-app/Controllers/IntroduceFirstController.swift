//
//  IntroduceFirstController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/19/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView

class IntroduceFirstController: BaseViewController {
    
    @IBOutlet weak var bgVisualEffect: VisualEffectView!
    
    override func viewDidLoad() {
        
        bgVisualEffect.colorTintAlpha = 0.2
        bgVisualEffect.blurRadius = 3
        bgVisualEffect.scale = 1
        bgVisualEffect.clipsToBounds = true

        bgVisualEffect.layer.cornerRadius = 15
        
        super.viewDidLoad()
        title = "DetailPromotionController"
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        let params = [
            K_GrantType: "password",
            K_Username: "MobileFDLR",
            K_Password: "1234!@#$",
            K_UsernameClient: "admin2",
            K_PasswordClient: "111111"
        ]
        print(params)
//        self.showProgress()
        BaseService.shared.getToken(params: params as [String : AnyObject]) { (status, response) in
//            self.hideProgress()
            if status {
                print("------")
                print(response)
                print("------")
                if let accessToken = response[K_AccessToken] as? String {
                    App.shared.save(value: accessToken as AnyObject, forKey: K_CURRENT_TOKEN)
                    App.shared.save(value: response as AnyObject, forKey: K_CURRENT_USER)
//                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
//                    self.present(newViewController, animated: true, completion: nil)
                } else {
                    self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    
    @IBAction func goToStart(_ sender: UIButton) {
        

    }
    
    
}
