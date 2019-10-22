//
//  PaymentProgessViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/31/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SVPinView
class PaymentProgessViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var paypalView: UIView!
    @IBOutlet weak var masterCardView: UIView!
    
    @IBOutlet weak var saveInfo: CheckBox!
    @IBOutlet weak var holderName: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    
    @IBOutlet weak var cvvNumber: UILabel!
    @IBOutlet weak var ExpDate: UILabel!
    
    
    var BookingID: String!
    
    @IBOutlet weak var cardNo: TextField!
    @IBOutlet weak var cardExprired: TextField!
    @IBOutlet weak var cvv: TextField!
    
    @IBOutlet weak var backgroundCard: UIView!
    @IBOutlet weak var cardName: TextField!
    
    @IBOutlet var viewParent: UIView!
    @IBOutlet var modalVerify: UIView!
    var VerifyCode: String?
    
    @IBOutlet weak var code: SVPinView!
    
    
    
    var visaStatus = false
    var masterCardStatus = false
    var paypalStatus = false
    
    var CheckInDate: String?
    var CheckOutDate: String?
    var Adult: String?
    var Child: String?
    var RoomPrice: String?
    var Quantity: String?
    var PropertyRoomID: String?
    var GrandTotal: String?
    var phone: String?
    var email: String?
    var country: String?
    var paymentMethod: String?
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDatePicker()
        // Hidden Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)

        self.backgroundCard.backgroundColor = UIColor(patternImage: UIImage(named: "cedit_card")!)
        
        self.cardNo.addTarget(self, action: #selector(self.updateCardNo(_:)), for: .editingChanged)
        self.cardExprired.addTarget(self, action: #selector(self.updateExpDate(_:)), for: .editingChanged)
        self.cardName.addTarget(self, action: #selector(self.updateCardName(_:)), for: .editingChanged)
        self.cvv.addTarget(self, action: #selector(self.updateCVV(_:)), for: .editingChanged)
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
        
        cardExprired.inputAccessoryView = toolbar
        cardExprired.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        cardExprired.text = formatter.string(from: datePicker.date)
        self.ExpDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func updateCardNo (_ textField: UITextField) {
        let newText = String((textField.text as! String)
            .filter({ $0 != " " }).prefix(16))
        
        textField.text = newText.chunkFormatted()
        self.cardNumber.text = newText.chunkFormatted()
    }
    @objc func updateCardName (_ textField: UITextField) {
        self.holderName.text = textField.text?.uppercased()
    }
    @objc func updateExpDate (_ textField: UITextField) {
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "dd/MM/yyyy"
//
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
//        var cardExprired = ""
//        if let cardFormat = dateFormatterGet.date(from: textField.text!) {
//            cardExprired = dateFormatterPrint.string(from: cardFormat)
//        }
        self.ExpDate.text = textField.text
    }
    
    @objc func updateCVV (_ textField: UITextField) {
        var text = ""
        for i in 0..<textField.text!.count {
            text = text + "*"
        }
        textField.text = String(textField.text!.prefix(3))
        self.cvvNumber.text = String(text.prefix(3))
    }
    
    func animateIn(_ desiredView: UIView) {
        
        let backgroundView = viewParent!
        desiredView.frame = CGRect(x: 0, y: 0, width: viewParent.frame.width, height: viewParent.frame.height)
        backgroundView.addSubview(desiredView)
        
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        }, completion: { _ in
//            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//            statusBar.isHidden = true
        })
        
        
    }
    
    func animateOut(_ desiredView: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.alpha = 0
        }) { _ in
            desiredView.removeFromSuperview()
//            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//            statusBar.isHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
        
        return false
    }
    
    
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func tapSaveInfo(_ sender: Any) {
        if saveInfo.isChecked == true {
            saveInfo.isChecked = false
        } else {
            saveInfo.isChecked = true
        }
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
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
        setActiveCart()
        let currenCard = App.shared.getStringAnyObject(key: "INFO_CREDIT_CARD")
        if currenCard["CardNo"] != nil {
            self.cvv.text = currenCard["CCV"] as? String
            self.cardNo.text = currenCard["CardNo"] as? String
            self.cardName.text = (currenCard["CustName"] as? String)?.uppercased()
            self.cardExprired.text = currenCard["ExpiredDate"] as? String
            
            self.cvvNumber.text = currenCard["CCV"] as? String
            self.cardNumber.text = currenCard["CardNo"] as? String
            self.holderName.text = (currenCard["CustName"] as? String)?.uppercased()
            self.ExpDate.text = currenCard["ExpiredDate"] as? String
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
        
    }
    
    func setActiveCart() {
        if visaStatus == true {
            self.visaView.layer.borderWidth = 1.5
            self.visaView.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.masterCardView.layer.borderWidth = 0
            self.paypalView.layer.borderWidth = 0
            self.masterCardStatus = false
            self.paypalStatus = false
        } else if paypalStatus == true {
            self.paypalView.layer.borderWidth = 1.5
            self.paypalView.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.masterCardView.layer.borderWidth = 0
            self.visaView.layer.borderWidth = 0
            self.masterCardStatus = false
            self.visaStatus = false
        } else if masterCardStatus == true {
            self.masterCardView.layer.borderWidth = 1.5
            self.masterCardView.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.paypalView.layer.borderWidth = 0
            self.visaView.layer.borderWidth = 0
            self.visaStatus = false
            self.paypalStatus = false
        }
    }

    @IBAction func chosseVisa(_ sender: Any) {
        if visaStatus {
            visaStatus = false
        } else {
            visaStatus = true
        }
        
        
        if visaStatus == true {
            self.visaView.layer.borderWidth = 1.5
            self.visaView.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.masterCardView.layer.borderWidth = 0
            self.paypalView.layer.borderWidth = 0
            self.masterCardStatus = false
            self.paypalStatus = false
        } else {
            self.visaView.layer.borderWidth = 0
        }
    }
    
    @IBAction func chossePaypal(_ sender: Any) {
        if paypalStatus {
            paypalStatus = false
        } else {
            paypalStatus = true
        }
        
        if paypalStatus == true {
            self.paypalView.layer.borderWidth = 1.5
            self.paypalView.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.masterCardView.layer.borderWidth = 0
            self.visaView.layer.borderWidth = 0
            self.masterCardStatus = false
            self.visaStatus = false
        } else {
            self.paypalView.layer.borderWidth = 0
        }
    }
    
    @IBAction func chosseMasterCard(_ sender: Any) {
        if masterCardStatus {
            masterCardStatus = false
        } else {
            masterCardStatus = true
        }
        
        if masterCardStatus == true {
            self.masterCardView.layer.borderWidth = 1.5
            self.masterCardView.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.paypalView.layer.borderWidth = 0
            self.visaView.layer.borderWidth = 0
            self.visaStatus = false
            self.paypalStatus = false
        } else {
            self.masterCardView.layer.borderWidth = 0
        }
    }
    @IBAction func closeModal(_ sender: Any) {
        self.animateOut(modalVerify)
    }
    
    @IBAction func pay(_ sender: Any) {
        
        if self.VerifyCode == self.code.getPin() {
            let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
                var username = ""
                if currentUser["LoginName"] != nil {
                    username = currentUser["LoginName"] as! String
                } else {
                   username = UIDevice.current.identifierForVendor!.uuidString
               }
                let paramCard = [
                    "UserName": username,
                    "UserCreditCardTypeID": "1",
                    "CardNo": self.cardNo.text!,
                    "CustName": self.cardName.text!,
                    "ExpiredDate": self.cardExprired.text!,
                    "CCV": self.cvv.text!,
                    "CreatedBy": currentUser["LoginName"]
                    ] as [String : Any]
                self.showProgress()
                BaseService.shared.updatePaymentInfo(params: paramCard as [String : AnyObject]) { (status, response) in
                    self.hideProgress()
                    print(response)
                    if status {
                        if let _ = response["Data"]{
                            
                            DispatchQueue.main.async(execute: {
                                if (response["Message"] as? String == "Success") {
                                    
                                    if self.saveInfo.isChecked {
                                        let paramCard = [
                                            "UserCreditCardTypeID": "1",
                                            "CardNo": self.cardNo.text!,
                                            "CustName": self.cardName.text!,
                                            "ExpiredDate": self.cardExprired.text!,
                                            "CCV": self.cvv.text!,
                                            ] as [String : Any]
                                        App.shared.save(value: paramCard as AnyObject, forKey: "INFO_CREDIT_CARD")
                                    }
                                    
                                    
                                    
                                    let params = [
                                        "UserName" : username
                                        ,"GuestName" : username
                                        ,"Title" :""
                                        ,"Phone" : self.phone!
                                        ,"Email" : self.email!
                                        ,"Address" :""
                                        ,"City" :""
                                        ,"State":""
                                        ,"PostCode" :""
                                        ,"Country" : self.country!
                                        ,"Notes" :""
                                        ,"PropertyRoomID" : self.PropertyRoomID!
                                        ,"CheckInDate" : self.CheckInDate!
                                        ,"CheckOutDate" : self.CheckOutDate!
                                        ,"Adult" : self.Adult!
                                        ,"Child" : self.Child!
                                        ,"ChildAge" : ""
                                        ,"RoomPrice" : self.RoomPrice!
                                        ,"ExtraItem" : ""
                                        ,"Taxes" :""
                                        ,"Payment" :"1"
                                        ,"PaymentMethodID": self.paymentMethod!
                                        ,"Remaining" :""
                                        ,"GrandTotal" : self.GrandTotal!
                                        ,"ChannelBooking" :"M",
                                         "Quantity": self.Quantity!
                                        ] as [String : Any]
                                    
                                    BaseService.shared.bookRoom(params: params as [String : AnyObject]) { (status, response) in
                                        self.hideProgress()
                                        if status {
                                            if let _ = response["Data"] {
                                                
                                                DispatchQueue.main.async(execute: {
                                                    if (response["Data"]!["BookingID"] != nil) {
                                                        print(response["Data"])
                                                        if let result = response["Data"]!["BookingID"] {
                                                            
                                                            self.BookingID = "\(String(describing: result!))"
                                                            print(self.BookingID)
                                                        }
                                                        self.performSegue(withIdentifier: "paymentViewSuccess", sender: nil)
                                                    } else {
                                                        self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                                                    }
                                                })
                                                
                                                
                                            } else {
                                                self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                                            }
                                        } else {
                                            self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                                        }
                                    }
                                } else {
                                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
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
    
    
    @IBAction func paymentBook(_ sender: Any) {
        
        // Updat Info Card
        if (self.cardNo.text == nil || self.cardNo.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền số thẻ")
        } else if (self.cardName.text == nil || self.cardName.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền tên chủ thẻ")
        } else if (self.cardExprired.text == nil || self.cardExprired.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền hạn của thẻ")
        }  else if (self.cvv.text == nil || self.cvv.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền cvv")
        } else {
            let refreshAlert = UIAlertController(title: "XÁC NHẬN ĐẶT PHÒNG", message: "Bạn chắc chắn đặt phòng này", preferredStyle: UIAlertController.Style.alert)
            
                            
            refreshAlert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
                self.animateIn(self.modalVerify)
                let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
                let paramVerify = [
                    "Telephone": currentUser["LoginName"],
                    "VerifyType": "1"
                    ] as [String : Any]
                BaseService.shared.verifyCode(params: paramVerify as [String : AnyObject]) { (status, response) in
                    self.hideProgress()
                    if status {
                        print(response)
                        if let _ = response["Data"]!["ID"] {
                            self.VerifyCode = "\(String(describing: response["Data"]!["VerifyCode"]!!))"

                        } else {
                            self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                        }

                    } else {
                        self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                    }
                }

                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Quay lại", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentViewSuccess" {
            if let viewController: PaymentSuccessViewController = segue.destination as? PaymentSuccessViewController {
                viewController.NumberVisaOrPoint = self.cardNo.text!
                viewController.BookingID = self.BookingID!
            }
        }
    }
    
    
}
