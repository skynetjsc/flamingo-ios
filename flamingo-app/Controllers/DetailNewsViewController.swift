//
//  DetailNewsViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class DetailNewsViewController: BaseViewController {

    @IBOutlet weak var titlePromotion: UILabel!
    @IBOutlet weak var timePromotion: UILabel!
    
    @IBOutlet weak var heightEqual: NSLayoutConstraint!
    @IBOutlet weak var imagePromotion: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var id = "0"
    
    @IBOutlet weak var contentTV: UITextView!
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
        if self.id == "0" {
            self.showDetailNews()
        } else {
            self.getDetailNews()
        }
        
    }
    
    
    func getDetailNews() {
        let params = [
            "ID": self.id
        ]
        self.showProgress()
        BaseService.shared.detailNews(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            print(response)
            if status {
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        if let data = response["Data"]! as? [String: Any] {
//                            self.titlePromotion.text = data["Title"] as? String
//
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

                            let dateFormatterPrint = DateFormatter()
                            dateFormatterPrint.dateFormat = "dd/MM/yyyy"
//
                            var startTime = ""
                            var endTime = ""

                            if let timeReceipt = dateFormatterGet.date(from: (data["FromTime"] as? String)!) {
                                startTime = dateFormatterPrint.string(from: timeReceipt)
                            } else {
                                startTime = (data["FromTime"] as? String)!
                            }
                            if let timeEnd = dateFormatterGet.date(from: (data["ToTime"] as? String)!) {
                                endTime = dateFormatterPrint.string(from: timeEnd)
                            } else {
                                endTime = (data["ToTime"] as? String)!
                            }
//
//                            self.timePromotion.text = "Từ ngày \(startTime) đến hết ngày \(endTime)"
//
//                    //        self.content.text = self.data["Content"] as? String
//
                            var contentTitle = "<h2> \(data["Title"] as! String)</h2><br> <p>Từ ngày \(startTime) đến hết ngày \(endTime)</p> <div style='  position: relative; width: 100%;height: 220px;overflow: hidden;'><div style='position: absolute;top: 0;left: 0;width: 100%;height: 100%;overflow: hidden;'><img style='  position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;min-width: 50%;min-height: 13%;' src=\"\(data["Picture1"]  as! String)\" /></div></div>"
                            contentTitle = contentTitle + String((data["Content"] as? String)!)
                            do {
                                let attrStr = try NSAttributedString(
                                    data: (contentTitle).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                    options: [ .documentType: NSAttributedString.DocumentType.html],
                                    documentAttributes: nil)
                                let font = UIFont(name: "Helvetica", size: 17.0)

                                self.contentTV.attributedText = attrStr
                    //            let height = self.content.heightForLabel(text: self.contentTV.text!, font: font!, width: self.view.frame.width)
                    //            self.heightEqual.constant = height
                    //            print(height)

                            } catch let error {

                            }
//
//                            self.imagePromotion.downloaded(from: (self.data["Picture1"]  as? String)!)
//                            self.imagePromotion.contentMode = .scaleAspectFill
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
    
    func showDetailNews() {
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
        
//        self.content.text = self.data["Content"] as? String
        
        var contentTitle = "<h2> \(self.data["Title"] as! String)</h2><br> <p>Từ ngày \(startTime) đến hết ngày \(endTime)</p> <div style='  position: relative; width: 100%;height: 220px;overflow: hidden;'><div style='position: absolute;top: 0;left: 0;width: 100%;height: 100%;overflow: hidden;'><img style='  position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin: auto;min-width: 50%;min-height: 13%;' src=\"\(self.data["Picture1"]  as! String)\" /></div></div>"
        contentTitle = contentTitle + String((self.data["Content"] as? String)!)
        do {
            let attrStr = try NSAttributedString(
                data: (contentTitle).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ .documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            let font = UIFont(name: "Helvetica", size: 17.0)
            
            self.contentTV.attributedText = attrStr
//            let height = self.content.heightForLabel(text: self.contentTV.text!, font: font!, width: self.view.frame.width)
//            self.heightEqual.constant = height
//            print(height)
            
        } catch let error {
            
        }
        
        self.imagePromotion.downloaded(from: (self.data["Picture1"]  as? String)!)
        self.imagePromotion.contentMode = .scaleAspectFill
    }
    


}
