//
//  ListRecieptViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ListRecieptViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var listReceipt = [[String: Any]]()
    
    var itemReceipt = [String: Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CÁC GIAO DỊCH"
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
//        //        self.backgroundView.image = UIImage(named: "bg_home")
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
//        self.navigationController?.navigationBar.barStyle = .black
        self.getListReceipt()
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
        return self.listReceipt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListReceiptTableViewCell", for: indexPath) as! ListReceiptTableViewCell
        
        cell.title.text = "\(String(describing: self.listReceipt[indexPath.row]["Title"]!))"
        cell.receiptID.text = "#\(String(describing: self.listReceipt[indexPath.row]["BookingID"]!))"
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
            print(dateFormatterPrint.string(from: timeReceipt))
            cell.time.text = dateFormatterPrint.string(from: timeReceipt)
        } else {
            cell.time.text = self.listReceipt[indexPath.row]["CreatedDate"] as? String
        }
        
        
        cell.pointValue.text = Int(pointVal)?.formattedWithSeparator
        
        
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
