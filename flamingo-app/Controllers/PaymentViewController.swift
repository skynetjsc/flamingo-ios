//
//  PaymentViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/31/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class PaymentViewController: BaseViewController {

    
    @IBOutlet weak var paypal: UIView!
    @IBOutlet weak var masterCard: UIView!
    @IBOutlet weak var visa: UIView!
    @IBOutlet weak var usePoint: CheckBox!
    @IBOutlet weak var checkAccept: CheckBox!
    
    var visaStatus = false
    var masterCardStatus = false
    var paypalStatus = false
    var BookingID: String!
    
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
    
    
    
    @IBOutlet weak var txtPoint: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usePoint.isChecked = true
        self.checkAccept.isChecked = true
    }
    
    
    
    
    @IBAction func payVisa(_ sender: Any) {
        if visaStatus {
            visaStatus = false
        } else {
            visaStatus = true
        }
        
        
        if visaStatus == true {
            self.visa.layer.borderWidth = 1.5
            self.visa.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.masterCard.layer.borderWidth = 0
            self.paypal.layer.borderWidth = 0
            self.usePoint.isChecked = false
            self.masterCardStatus = false
            self.paypalStatus = false
        } else {
                self.visa.layer.borderWidth = 0
        }
        
    }
    @IBAction func payPaypal(_ sender: Any) {
        
        if paypalStatus {
            paypalStatus = false
        } else {
            paypalStatus = true
        }
        
        if paypalStatus == true {
            self.paypal.layer.borderWidth = 1.5
            self.paypal.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.masterCard.layer.borderWidth = 0
            self.visa.layer.borderWidth = 0
            self.masterCardStatus = false
            self.visaStatus = false
        } else {
            self.paypal.layer.borderWidth = 0
        }
    }
    @IBAction func payMasterCard(_ sender: Any) {
        if masterCardStatus {
            masterCardStatus = false
        } else {
            masterCardStatus = true
        }
        
        if masterCardStatus == true {
            self.masterCard.layer.borderWidth = 1.5
            self.masterCard.layer.borderColor = UIColor(red:219/255, green:11/255, blue:69/255, alpha: 1).cgColor
            self.paypal.layer.borderWidth = 0
            self.visa.layer.borderWidth = 0
            self.visaStatus = false
            self.paypalStatus = false
        } else {
            self.masterCard.layer.borderWidth = 0
        }
    }
    @IBAction func pointCheckbox(_ sender: Any) {
        if !self.usePoint.isChecked {
            self.usePoint.isChecked = false
            
            self.visa.layer.borderWidth = 0
            self.visaStatus = false
        }
    }
    @IBAction func usePoint(_ sender: Any) {
        if usePoint.isChecked == true {
            usePoint.isChecked = false
        } else {
            
            self.visa.layer.borderWidth = 0
            self.visaStatus = false
            usePoint.isChecked = true
        }
    }
    @IBAction func checkAccept(_ sender: Any) {
        if checkAccept.isChecked == true {
            checkAccept.isChecked = false
        } else {
            checkAccept.isChecked = true
        }
    }
    
    @IBAction func nextPayment(_ sender: Any) {
        
        if (self.checkAccept.isChecked == false) {
            self.showMessage(title: "Flamingo", message: "Vui lòng đồng ý với điều khoản của chúng tôi")
        } else if self.usePoint.isChecked == false && self.visaStatus == false {
            self.showMessage(title: "Flamingo", message: "Vui lòng chọn phưong thức thanh toán")
        } else {
            if self.visaStatus == true {
                self.paymentMethod = "1"
                self.performSegue(withIdentifier: "PaymentProgess", sender: nil)
            } else {
                
                var refreshAlert = UIAlertController(title: "XÁC NHẬN ĐẶT PHÒNG", message: "Bạn chắc chắn đặt phòng này", preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                    let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
                    
                    let params = [
                        "UserName" : currentUser["LoginName"]
                        ,"GuestName" : currentUser["LoginName"]
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
                        ,"Payment" : self.GrandTotal!
                        ,"PaymentMethodID": "2"
                        ,"Remaining" :""
                        ,"GrandTotal" : self.GrandTotal!
                        ,"ChannelBooking" :"M",
                         "Quantity": self.Quantity!
                        ] as [String : Any]
                    
                    BaseService.shared.bookRoom(params: params as [String : AnyObject]) { (status, response) in
                        self.hideProgress()
                        if status {
                            if let _ = response["Data"] {
                                print(response)
                                DispatchQueue.main.async(execute: {
                                    if let result = response["Data"]!["BookingID"] {
                                        
                                        self.BookingID = "\(String(describing: result!))"
                                        print(self.BookingID)
                                        self.performSegue(withIdentifier: "paymentPoint", sender: nil)
                                        
                                    }  else {
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
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Quay lại", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
        }
        
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "PaymentProgess" {
            if let viewController: PaymentProgessViewController = segue.destination as? PaymentProgessViewController {
                viewController.paymentMethod = self.paymentMethod!
                viewController.email = self.email!
                viewController.phone = self.phone!
                viewController.country = self.country!
                viewController.CheckInDate = self.CheckInDate!
                viewController.CheckOutDate = self.CheckOutDate!
                viewController.Adult =  String(describing: self.Adult!)
                viewController.Child = String(describing: self.Child!)
                viewController.RoomPrice = String(describing: self.RoomPrice!)
                viewController.Quantity = String(describing: self.Quantity!)
                viewController.PropertyRoomID = self.PropertyRoomID!
                viewController.GrandTotal = String(describing: GrandTotal!)
            }
        } else if segue.identifier == "paymentPoint" {
            if let viewController: PaymentSuccessViewController = segue.destination as? PaymentSuccessViewController {
                viewController.BookingID = self.BookingID!
                viewController.NumberVisaOrPoint = "FPOINT"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
        print(userInfo)
        let point = userInfo["Point"]!
        print(point)
        var textPoint = String(describing: point)
        if textPoint.elementsEqual("<null>") || textPoint.elementsEqual("") {
            textPoint = "0"
        }
//        if Int(textPoint)! < 0 {
//            textPoint = "0"
//        }
        
        self.txtPoint.text =  "(\(Int(textPoint)!.formattedWithSeparator) điểm sẵn có)"
    }
    
}
