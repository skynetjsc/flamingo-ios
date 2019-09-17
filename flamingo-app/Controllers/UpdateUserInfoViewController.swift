//
//  UpdateUserInfoViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class UpdateUserInfoViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var birthday: UITextField!
    
    
    let genderData = [String](arrayLiteral: "Ông", "Bà")
    let theGender = UIPickerView()
    let datePicker = UIDatePicker()
    
    
    
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
        
        var hAddress = userInfo["HomeAddress"]!
        var address = String(describing: hAddress)
        if address.elementsEqual("<null>") || address.elementsEqual("") {
            address = ""
        }
        
        var email = userInfo["Email"]!
        var emailCheck = String(describing: email)
        if emailCheck.elementsEqual("<null>") || emailCheck.elementsEqual("") {
            emailCheck = ""
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        print(userInfo)
        var bỉth = userInfo["BirthOfDate"]!
        var bỉthStr = String(describing: bỉth)
        if bỉthStr.elementsEqual("<null>") || bỉthStr.elementsEqual("") {
            self.birthday.text = ""
        } else {
            if let birthday = dateFormatterGet.date(from: bỉthStr) {
                self.birthday.text = dateFormatterPrint.string(from: birthday)
            } else {
                self.birthday.text = userInfo["BirthOfDate"] as? String
            }
        }
        
        
        
        self.firstName.text = firstName
        self.lastName.text = lastName
        self.address.text = address
        self.email.text = emailCheck
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
    
    
    @IBAction func updateUserInfo(_ sender: Any) {
        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
        print(userInfo)
        if (self.firstName.text == nil || self.firstName.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        } else if (self.email.text == nil || self.email.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        } else if (self.lastName.text == nil || self.lastName.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        }  else if (self.address.text == nil || self.address.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        }  else if (self.birthday.text == nil || self.birthday.text == "") {
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
        
        let params = [
            "ID": userInfo["ID"],
            "FirstName" : self.firstName.text!,
            "MiddleName" :"",
            "LastName" : self.lastName.text!,
            "Sex" : self.gender.text!,
            "AvatarPath" :"",
            "JobDescription" :"",
            "CountryID" :"",
            "BirthOfDate" : birthday,
            "HandPhone" :"",
            "HomeAddress" : self.address.text!,
            "Resident" :"",
            "PostalCode" :"",
            "Communication" :"",
            "Email" : self.email.text!,
            "UpdatedBy" :"gianglt"
            ] as [String : Any]
        
        BaseService.shared.updateUserInfo(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        if let userInfo = response["Data"]! as? [[String: Any]] {
                            print("123")
                            App.shared.save(value: response["Data"] as AnyObject, forKey: "USER_INFO")
                            
                        }
                        self.showMessage(title: "Flamingo", message: "Cập nhật thông tin thành công")
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
