//
//  UpdateUserInfoLastViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/26/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift

class UpdateUserInfoLastViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {

        @IBOutlet weak var gender: UITextField!
        @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var birthday: UITextField!
        
        
        let genderData = [String](arrayLiteral: "Ông", "Bà")
        let theGender = UIPickerView()
        let datePicker = UIDatePicker()
        
        var Telephone: String?
        var Password: String?
        var UserInfoID: String?
        var LoginSocail: Bool = false

        var firstNameStr: String?
        var lastNameStr: String?
        
        override func viewDidLoad() {
            super.viewDidLoad()

            gender.inputView = theGender
            theGender.delegate = self
            theGender.dataSource = self
            gender.delegate = self
            
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
            view.addGestureRecognizer(tapGesture)
            self.showDatePicker()
            
            title = "CẬP NHẬT THÔNG TIN"
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        func showDatePicker(){
            //Formate Date
            datePicker.datePickerMode = .date
            
            //ToolBar
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Xong", style: .plain, target: self, action: #selector(donedatePicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Huỷ", style: .plain, target: self, action: #selector(cancelDatePicker));
            
            toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
            
            birthday.inputAccessoryView = toolbar
            birthday.inputView = datePicker
            
        }
        
        @objc func donedatePicker(){
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            birthday.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }
        
        @objc func cancelDatePicker(){
            self.view.endEditing(true)
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
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            return self.genderData.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                return self.genderData[row]
            
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            if pickerView == theGender {
                
                gender.text = self.genderData[row]
                self.view.endEditing(false)
            }
        }
        
        func removeObservers() {
            NotificationCenter.default.removeObserver(self)
        }
        
    @IBAction func skipStep(_ sender: Any) {
        if self.LoginSocail == true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
        } else {
            let params = [
            "UserName": self.Telephone,
            "Password": self.Password
                ]
            BaseService.shared.login(params: params as [String : AnyObject]) { (status, response) in
                        self.hideProgress()
                        if status {
                            print(response)
                            if let _ = response["Data"]?["ID"] as? Int {
                                let userLoginTouchID = [
                                    "UserName": self.Telephone,
                                    "Password": self.Password,
                                    "Status": false
                                    ] as [String : Any]
                                App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
                                App.shared.save(value: userLoginTouchID as AnyObject, forKey: "USER_LOGIN")
            //                    self.getUserInfo((response["Data"]!["ID"] as? String)!)
                                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
                                                    newViewController.modalPresentationStyle = .fullScreen
                                                    self.present(newViewController, animated: true, completion: nil)
                            } else {
                                self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                            }
                        } else {
                            self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                        }
                    }
        }
        
        
    }
    
        @IBAction func updateUserInfo(_ sender: Any) {
            
            if (self.birthday.text == nil || self.birthday.text == "") {
                self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
            }  else if (self.gender.text == nil || self.gender.text == "") {
                self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
            }
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd/MM/yyyy"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd"
            var birthday = ""
            if let birthdayFormat = dateFormatterGet.date(from: self.birthday.text!) {
                birthday = dateFormatterPrint.string(from: birthdayFormat)
            }
            let ID = self.UserInfoID!
            let params = [
                "ID": ID,
                "FirstName" : self.firstNameStr!,
                "MiddleName" :"",
                "LastName" : self.lastNameStr!,
                "Sex" : self.gender.text!,
                "AvatarPath" :"",
                "JobDescription" :"",
                "CountryID" :"",
                "BirthOfDate" : birthday,
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
                                let params = [
                                    "UserName": self.Telephone,
                                    "Password": self.Password
                                        ]

                                let alert = UIAlertController(title: "Flamingo", message: "Cập nhật thông tin thành công", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                                    if self.LoginSocail == true {
                                        App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
                                        newViewController.modalPresentationStyle = .fullScreen
                                        self.present(newViewController, animated: true, completion: nil)
                                    } else {
                                        BaseService.shared.login(params: params as [String : AnyObject]) { (status, response) in
                                                    self.hideProgress()
                                                    if status {
                                                        print(response)
                                                        if let _ = response["Data"]?["ID"] as? Int {
                                                            let userLoginTouchID = [
                                                                "UserName": self.Telephone,
                                                                "Password": self.Password,
                                                                "Status": false
                                                                ] as [String : Any]
                                                            App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
                                                            App.shared.save(value: userLoginTouchID as AnyObject, forKey: "USER_LOGIN")
                                        //                    self.getUserInfo((response["Data"]!["ID"] as? String)!)
                                                                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
                                                                                newViewController.modalPresentationStyle = .fullScreen
                                                                                self.present(newViewController, animated: true, completion: nil)
                                                        } else {
                                                            self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                                                        }
                                                    } else {
                                                        self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                                                    }
                                                }
                                    }
                                    
                                }))
                                self.present(alert, animated: true)
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
}
