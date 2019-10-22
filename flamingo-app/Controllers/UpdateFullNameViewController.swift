//
//  UpdateFullNameViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/26/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift

class UpdateFullNameViewController: BaseViewController {

        @IBOutlet weak var firstName: UITextField!
        @IBOutlet weak var lastName: UITextField!
        @IBOutlet weak var scrollView: UIScrollView!
        
        
//        let genderData = [String](arrayLiteral: "Ông", "Bà")
//        let theGender = UIPickerView()
//        let datePicker = UIDatePicker()
        
        var Telephone: String?
        var Password: String?
        var UserInfoID: String?
        var firstNameStr: String?
        var lastNameStr: String?
        var LoginSocail: Bool = false
        
        override func viewDidLoad() {
            super.viewDidLoad()

            
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
            view.addGestureRecognizer(tapGesture)
            
            title = "CẬP NHẬT THÔNG TIN"
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        @objc func didTapView(gesture: UITapGestureRecognizer) {
            view.endEditing(true)
        }
        
        func addObservers() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
                self.keyboardWillShow(notification: notification)
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
                self.keyboardWillHide(notification: notification)
            }
        }
        
        func keyboardWillShow(notification: Notification) {
            guard let userInfo = notification.userInfo, let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
            scrollView.contentInset = contentInset
        }
        
        func keyboardWillHide(notification: Notification) {
            scrollView.contentInset = UIEdgeInsets.zero
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            
            return 1
        }
        
        func removeObservers() {
            NotificationCenter.default.removeObserver(self)
        }
        
        
        @IBAction func updateUserInfo(_ sender: Any) {
            if (self.firstName.text == nil || self.firstName.text == "") {
                self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
            } else if (self.lastName.text == nil || self.lastName.text == "") {
                self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
            }
            self.firstNameStr = self.firstName.text!
            self.lastNameStr = self.lastName.text!
            
            let ID = self.UserInfoID!
            let params = [
                "ID": ID,
                "FirstName" : self.firstNameStr!,
                "MiddleName" :"",
                "LastName" : self.lastNameStr!,
                "Sex" : "",
                "AvatarPath" :"",
                "JobDescription" :"",
                "CountryID" :"",
                "BirthOfDate" : "",
                "HandPhone" :"",
                "HomeAddress" : "",
                "Resident" :"",
                "PostalCode" :"",
                "Communication" :"",
                "Email" : "",
                "UpdatedBy" : self.Telephone!
                ] as [String : Any]
            BaseService.shared.updateUserInfo(params: params as [String : AnyObject]) { (status, response) in
                self.hideProgress()
                if status {
                    if let _ = response["Data"]!["ID"]{
                        
                        DispatchQueue.main.async(execute: {
                            if let userInfo = response["Data"]!["ID"] {
                                App.shared.save(value: response["Data"] as AnyObject, forKey: "USER_INFO")
                                self.performSegue(withIdentifier: "lastUpdateInfo", sender: nil)
                            } else {
                                self.showMessage(title: "Flamingo", message: "Cập nhật thông tin không thành công!!!")
                            }
                        })
                        
                    } else {
                        self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                    }
                } else {
                    self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                }
            }
            
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lastUpdateInfo" {
            if let viewController: UpdateUserInfoLastViewController = segue.destination as? UpdateUserInfoLastViewController {
                viewController.Telephone = Telephone!
                viewController.Password = Password!
                viewController.LoginSocail = self.LoginSocail
                viewController.firstNameStr = self.firstNameStr!
                viewController.lastNameStr = self.lastNameStr!
                viewController.UserInfoID = self.UserInfoID!
            }
        }
    }
        

}
