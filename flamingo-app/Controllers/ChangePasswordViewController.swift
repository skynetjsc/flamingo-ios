//
//  ChangePasswordViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/7/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var newPassword: TextField!
    @IBOutlet weak var confirmPassword: TextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "THAY ĐỔI MẬT KHẨU"

    }
    
    @IBAction func changePassword(_ sender: Any) {
        if (self.newPassword.text == nil || self.newPassword.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        } else if (self.confirmPassword.text == nil || self.confirmPassword.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        } else if (!(self.confirmPassword.text!.elementsEqual(self.newPassword.text!))) {
            self.showMessage(title: "Flamingo", message: "Mật khẩu xác thực không giống nhau")
        } else {
            let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
            let params = [
                "ID": userInfo["ID"],
                "Password" : self.newPassword.text!,
                ] as [String : Any]
            
            BaseService.shared.changePassword(params: params as [String : AnyObject]) { (status, response) in
                self.hideProgress()
                if status {
                    print(response)
                    if let _ = response["Data"]{
                        
                        DispatchQueue.main.async(execute: {
                            if let userInfo = response["Data"]! as? [[String: Any]] {
                                print("123")
                                //                            App.shared.save(value: response["Data"] as AnyObject, forKey: "USER_INFO")
                                
                            }
                            self.showMessage(title: "Flamingo", message: "Cập nhật mật khẩu thành công")
                        })
                        
                        
                        
                        
                    } else {
                        self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                    }
                } else {
                    self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                }
            }
        }
        
    }
    
}
