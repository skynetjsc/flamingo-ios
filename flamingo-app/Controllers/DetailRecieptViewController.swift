//
//  DetailRecieptViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class DetailRecieptViewController: UIViewController {

    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var bookingID: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var receiptID: UILabel!
    @IBOutlet weak var content: UILabel!
    
    
    var receiptInfo = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CHI TIẾT GIAO DỊCH"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.receiptID.text = "\(String(describing: self.receiptInfo["Title"]!))"
        self.time.text = self.receiptInfo["Location"] as? String
        var pointVal = ""
        if String(describing: self.receiptInfo["Value"]!).elementsEqual("<null>") {
            pointVal = "0"
        } else {
            pointVal = String(describing: self.receiptInfo["Value"]!)
        }
//        if Int(pointVal)! < 0 {
//            pointVal = "0"
//        }
        self.point.text = Int(pointVal)?.formattedWithSeparator
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm - dd/MM/yyyy"
        
        
        if let timeReceipt = dateFormatterGet.date(from: (self.receiptInfo["CreatedDate"] as? String)!) {
            print(dateFormatterPrint.string(from: timeReceipt))
            self.location.text = dateFormatterPrint.string(from: timeReceipt)
        } else {
            self.location.text = self.receiptInfo["CreatedDate"] as? String
        }

        self.bookingID.text = "\(String(describing: self.receiptInfo["BookingID"]!))"
        self.content.text = "\(String(describing: self.receiptInfo["Content"]!))"
        
        
    }


}
