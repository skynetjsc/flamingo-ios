//
//  PaymentInfoViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/31/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class PaymentInfoViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   

    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var name: TextField!
    @IBOutlet weak var phone: TextField!
    @IBOutlet weak var email: TextField!
    @IBOutlet weak var requiment: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnUserDefault: CheckBox!
    @IBOutlet weak var btnUserOther: CheckBox!
    
    
    let genderData = [String](arrayLiteral: "Ông", "Bà")
    var arrCountry = [String]()
    let theGender = UIPickerView()
    let theCountry = UIPickerView()
    
    var CheckInDate: String?
    var CheckOutDate: String?
    var Adult: String?
    var Child: String?
    var RoomPrice: String?
    var Quantity: String?
    var PropertyRoomID: String?
    var GrandTotal: String?
    var countryData: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hidden Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        gender.inputView = theGender
        theGender.delegate = self
        theGender.dataSource = self
        gender.delegate = self
        
        
        country.inputView = theCountry
        theCountry.delegate = self
        theCountry.dataSource = self
        country.delegate = self
        
        self.btnUserOther.isChecked = false
        self.btnUserDefault.isChecked = true
        
        setInput()
    }
    
    func setInput() {
        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
//        print(userInfo)
        if userInfo["FirstName"] != nil {
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
            
            var email = userInfo["Email"]!
            var Email = String(describing: email)
            if Email.elementsEqual("<null>") || Email.elementsEqual("") {
                Email = ""
            }
            
            var tphone = userInfo["Telephone"]!
            var Telephone = String(describing: tphone)
            if Telephone.elementsEqual("<null>") || Telephone.elementsEqual("") {
                Telephone = ""
            }
            
            if !firstName.elementsEqual("") {
                    self.name.text = "\(firstName) \(middleName) \(lastName)"
            } else {
                self.name.text = ""
            }
            
            self.phone.text = Telephone
            self.email.text = Email
        }
        
    }
    
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func isValidEmailAddress(_ emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
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
    
    @IBAction func chosseUserDefault(_ sender: Any) {
        if self.btnUserDefault.isChecked {
            self.btnUserDefault.isChecked = false
            self.name.text = ""
            self.phone.text = ""
            self.email.text = ""
        } else {
            self.btnUserDefault.isChecked = true
            self.btnUserOther.isChecked = false
            self.setInput()
        }
        
    }
    @IBAction func chosseBtnUserDefault(_ sender: Any) {
        
        if !self.btnUserDefault.isChecked {
            self.btnUserOther.isChecked = false
            self.setInput()
        }
        if self.btnUserDefault.isChecked {
            self.name.text = ""
            self.phone.text = ""
            self.email.text = ""
        }
    }
    
    @IBAction func chosseBtnUserOther(_ sender: Any) {
        
        if !self.btnUserOther.isChecked {
            self.btnUserDefault.isChecked = false
            
            self.name.text = ""
            self.phone.text = ""
            self.email.text = ""
        }
    }
    
    @IBAction func chosseUserOther(_ sender: Any) {
        if self.btnUserOther.isChecked {
            self.btnUserOther.isChecked = false
            self.setInput()
        } else {
            self.btnUserOther.isChecked = true
            self.btnUserDefault.isChecked = false
            self.name.text = ""
            self.phone.text = ""
            self.email.text = ""
        }
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == theCountry {
            return self.arrCountry.count
        }else {
            return self.genderData.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == theCountry {
            return self.arrCountry[row]
        } else {
            return self.genderData[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == theCountry {
            country.text = self.arrCountry[row]
            self.countryData = String(describing: row)
            self.view.endEditing(false)
        }
        if pickerView == theGender {
            
            gender.text = self.genderData[row]
            self.view.endEditing(false)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addObservers()
        self.getCountry()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
        
    }
    
    func getCountry() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "Username": currentUser["LoginName"]
            ] as [String : Any]
        BaseService.shared.listCountry(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                if let _ = response["Data"] {
                    
                    DispatchQueue.main.async(execute: {
                        print(response["Data"]!)
                        let data = response["Data"]!
                        
                        for file in data as! [AnyObject] {
                            self.arrCountry.append(file["Name"]! as! String)
                        }
                        self.countryData = self.arrCountry[0]
                        self.country.text = self.arrCountry[0]
                    })
                    
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    

    @IBAction func nextStep(_ sender: Any) {
        
        if (self.email.text == nil || self.email.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        } else if (self.email.text == nil || self.email.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        } else if (self.countryData == nil || self.countryData == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        }  else if (self.name.text == nil || self.name.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        } else if !isValidEmailAddress(self.email.text ?? "") {
            self.showMessage(title: "Flamingo", message: "Email không đúng địng dạng")
        }
        
        
        self.performSegue(withIdentifier: "Payment", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Payment" {
            if let viewController: PaymentViewController = segue.destination as? PaymentViewController {
                
                
                viewController.email = self.email.text
                viewController.phone = self.phone.text
                viewController.country = self.countryData
                viewController.CheckInDate = self.CheckInDate!
                viewController.CheckOutDate = self.CheckOutDate!
                viewController.Adult =  self.Adult!
                viewController.Child = self.Child!
                viewController.RoomPrice = self.RoomPrice!
                viewController.Quantity = self.Quantity!
                viewController.PropertyRoomID = self.PropertyRoomID!
                viewController.GrandTotal = GrandTotal!
            }
        }
    }
    
    
}
