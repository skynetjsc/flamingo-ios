//
//  UserDetailViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class UserDetailMenu: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateActive: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var point: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var vip: UILabel!
    
    @IBOutlet weak var birthday: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var listReceipt = [[String: Any]]()
    var listVipCartInfo = [String: Any]()
    
    var itemReceipt = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "THÔNG TIN KHÁCH HÀNG"
    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
        //        self.tableView.backgroundColor = color
        //
        //        //                self.backgroundView.backgroundColor = color
        //        self.navigationController?.navigationBar.tintColor = UIColor.gray
        //        self.navigationController?.navigationBar.backgroundColor = color
        //        UIApplication.shared.statusBarView?.backgroundColor = color
        ////        self.backgroundView.image = UIImage(named: "bg_home")
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        //        self.navigationController?.navigationBar.barStyle = .black
        self.getListReceipt()
        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
        print(userInfo)
        var fName = userInfo["FirstName"]!
        var firstName = String(describing: fName)
        if firstName.elementsEqual("<null>") || firstName.elementsEqual("") {
            firstName = "  "
        }
        
        var lName = userInfo["LastName"]!
        var lastName = String(describing: lName)
        if lastName.elementsEqual("<null>") || lastName.elementsEqual("") {
            lastName = "  "
        }
        
        var mName = userInfo["MiddleName"]!
        var middleName = String(describing: mName)
        if middleName.elementsEqual("<null>") || middleName.elementsEqual("") {
            middleName = "   "
        }
        
        var email = userInfo["Email"]!
        var Email = String(describing: email)
        if Email.elementsEqual("<null>") || Email.elementsEqual("") {
            Email = "   "
        }
        
        var tphone = userInfo["Telephone"]!
        var Telephone = String(describing: tphone)
        if Telephone.elementsEqual("<null>") || Telephone.elementsEqual("") {
            Telephone = "   "
        }
        
        self.phone.text = Telephone
        
        if !firstName.elementsEqual("") {
            self.dateActive.text = "\(firstName) \(middleName) \(lastName)"
        } else {
            self.dateActive.text = "   "
        }
        
        
        let point = userInfo["Point"]!
        
        var textPoint = String(describing: point)
        if textPoint.elementsEqual("<null>") || textPoint.elementsEqual("") {
            textPoint = "0"
        }
        
//        if Int(textPoint)! < 0 {
//            textPoint = "0"
//        }
        self.point.text = textPoint
        
        
        let dateFormatterGetBirth = DateFormatter()
        dateFormatterGetBirth.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrintBirth = DateFormatter()
        dateFormatterPrintBirth.dateFormat = "dd/MM/yyyy"
        
        //        if !String(describing: (userInfo["BirthOfDate"]  as? String)).elementsEqual("<null>") {
        //            if let birthday = dateFormatterGetBirth.date(from: (userInfo["BirthOfDate"]  as? String)!) {
        //                self.birthday.text = dateFormatterPrintBirth.string(from: birthday)
        //            } else {
        //                self.birthday.text = userInfo["BirthOfDate"] as? String
        //            }
        //
        //        }
        //        if userInfo["BirthOfDate"] != nil {
        //            if let birthday = dateFormatterGetBirth.date(from: (userInfo["BirthOfDate"]  as? String)!) {
        //                self.birthday.text = dateFormatterPrintBirth.string(from: birthday)
        //            } else {
        //                self.birthday.text = userInfo["BirthOfDate"] as? String
        //            }
        //        }
        var birthdayInfo = userInfo["BirthOfDate"]!
        var birthday = String(describing: birthdayInfo)
        if birthday.elementsEqual("<null>") || birthday.elementsEqual("") {
            birthday = "  "
        } else {
            if let birthdaytxt = dateFormatterGetBirth.date(from: birthday) {
                self.birthday.text = dateFormatterPrintBirth.string(from: birthdaytxt)
            } else {
                self.birthday.text = ""
            }
            
        }
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        
        if let datActive = dateFormatterGet.date(from: (userInfo["CreatedDate"]  as? String)!) {
            self.name.text = dateFormatterPrint.string(from: datActive)
        } else {
            self.name.text = "   "
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let offset = 1
        let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        //        let navigationcolor = UIColor.init(hue: 0, saturation: CGFloat(offset), brightness: 1, alpha: 1)
        self.tableView.backgroundColor = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let offset = 1
        let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        //        let navigationcolor = UIColor.init(hue: 0, saturation: CGFloat(offset), brightness: 1, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    
    @IBAction func viewAll(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "viewAll", sender: nil)
    }
    
    
    func getListReceipt() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        
        let params = [
            "Username": currentUser["LoginName"]!
            ] as [String : Any]
        BaseService.shared.vipCardInfo(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        if let listReceipt = response["Data"]!["TransactionInfo"] as? [[String: Any]] {
                            self.listReceipt = listReceipt
                        }
                        if let vipCard = response["Data"]!["VipCardInfo"] as? [String: Any] {
                            self.listVipCartInfo = vipCard

                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            
                            let dateFormatterPrint = DateFormatter()
                            dateFormatterPrint.dateFormat = "dd/MM/yyyy"
                            
                            
                            if let datActive = dateFormatterGet.date(from: (self.listVipCartInfo["CreatedDate"]  as? String)!) {
                                self.name.text = dateFormatterPrint.string(from: datActive)
                            } else {
                                self.name.text = "   "
                            }
                            var card = self.listVipCartInfo["CardCode"]!
                            var CardCode = String(describing: card)
                            if CardCode.elementsEqual("<null>") || CardCode.elementsEqual("") {
                                CardCode = "   "
                            }
                            self.cardNumber.text = CardCode
                            self.vip.text = "Hạn thẻ VIP 2"
                        }
                        
                        
                        
                        self.tableView.reloadData()
                    })
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.listReceipt.count >= 3 {
            return 3
        } else {
            return self.listReceipt.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDetailReceiptTableViewCell", for: indexPath) as! AccountDetailReceiptTableViewCell
        
        cell.title.text = "\(String(describing: self.listReceipt[indexPath.row]["Title"]!))"
        cell.receiptID.text = "#\(String(describing: self.listReceipt[indexPath.row]["ID"]!))"
        var pointVal = ""
        if String(describing: self.listReceipt[indexPath.row]["Value"]!).elementsEqual("<null>") {
            pointVal = "0"
        } else {
            pointVal = String(describing: self.listReceipt[indexPath.row]["Value"]!)
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm - dd/MM/yyyy"
        
        
        if let timeReceipt = dateFormatterGet.date(from: (self.listReceipt[indexPath.row]["CreatedDate"] as? String)!) {
            
            cell.dateTime.text = dateFormatterPrint.string(from: timeReceipt)
        } else {
            cell.dateTime.text = self.listReceipt[indexPath.row]["CreatedDate"] as? String
        }
        
        cell.point.text = pointVal
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemReceipt = self.listReceipt[indexPath.row]
        self.performSegue(withIdentifier: "DetailReciept", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailReciept" {
            if let viewController: DetailRecieptViewController = segue.destination as? DetailRecieptViewController {
                viewController.receiptInfo = self.itemReceipt
            }
        }
    }
    
}
