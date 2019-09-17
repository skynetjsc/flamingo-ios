//
//  DetailNewsViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class DetailNewsViewController: UIViewController {

    @IBOutlet weak var titlePromotion: UILabel!
    @IBOutlet weak var timePromotion: UILabel!
    
    @IBOutlet weak var heightEqual: NSLayoutConstraint!
    @IBOutlet weak var imagePromotion: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var data = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
//            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(data)
        self.titlePromotion.text = self.data["Title"] as? String
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        var startTime = ""
        var endTime = ""
        
        if let timeReceipt = dateFormatterGet.date(from: (self.data["FromTime"] as? String)!) {
            startTime = dateFormatterPrint.string(from: timeReceipt)
        } else {
            startTime = (self.data["FromTime"] as? String)!
        }
        if let timeEnd = dateFormatterGet.date(from: (self.data["ToTime"] as? String)!) {
            endTime = dateFormatterPrint.string(from: timeEnd)
        } else {
            endTime = (self.data["ToTime"] as? String)!
        }
        
        self.timePromotion.text = "Từ ngày \(startTime) đến hết ngày \(endTime)"
        
        self.content.text = self.data["Content"] as? String
        do {
            let attrStr = try NSAttributedString(
                data: String((self.data["Content"] as? String)!).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ .documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            let font = UIFont(name: "Helvetica", size: 17.0)
            var height = self.content.heightForLabel(text: attrStr.string, font: font!, width: self.view.frame.width)
            self.heightEqual.constant = height
            self.content.attributedText = attrStr
        } catch let error {
            
        }
        
        self.imagePromotion.downloaded(from: (self.data["Picture1"]  as? String)!)
        self.imagePromotion.contentMode = .scaleAspectFill
    }
    


}
