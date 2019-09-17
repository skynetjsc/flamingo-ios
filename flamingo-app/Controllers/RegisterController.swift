//
//  RegisterController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/19/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//


import UIKit

class RegisterController: BaseViewController {
    
    @IBOutlet weak var userName: TextField!
    @IBOutlet weak var password: TextField!
    @IBOutlet weak var confirmPassword: TextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func register(_ sender: Any) {
        
        let name: String? = self.userName.text
        let pass: String? = self.password.text
        
        let params = [
            "Telephone": name,
            "Password": pass
        ]
        
        BaseService.shared.register(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                if let _ = response[K_AccessToken] as? String {
//                    App.shared.save(value: response as AnyObject, forKey: K_CURRENT_USER_INFO)
                    //                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    //                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
                    //                    self.present(newViewController, animated: true, completion: nil)
                    self.showMessage(title: "Flamingo", message: "Đăng ký tài khoản thành công")
                } else {
                    self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
}
