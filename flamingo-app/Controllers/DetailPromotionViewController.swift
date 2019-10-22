//
//  DetailPromotionViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class DetailPromotionViewController: BaseViewController {

    
    @IBOutlet weak var titlePromotion: UILabel!
    @IBOutlet weak var timePromotion: UILabel!
    
    @IBOutlet weak var heightEqual: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagePromotion: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var code: UIButton!
    @IBOutlet weak var viewContent: UIView!
    
    var data = [String: Any]()
    var id = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.id == "0" {
            self.showPromotion()
        } else {
            self.getDetailPromotion()
        }
        
    }
    
    
    func getDetailPromotion() {
        let params = [
                    "ID": self.id
                ]
                self.showProgress()
                BaseService.shared.detailPromotion(params: params as [String : AnyObject]) { (status, response) in
                    self.hideProgress()
                    print(response)
                    if status {
                        if let _ = response["Data"]{
                            
                            DispatchQueue.main.async(execute: {
                                if let data = response["Data"]! as? [String: Any] {
                                    self.titlePromotion.text = data["Title"] as? String
                                    
                                    let dateFormatterGet = DateFormatter()
                                    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                                    
                                    let dateFormatterPrint = DateFormatter()
                                    dateFormatterPrint.dateFormat = "dd/MM/yyyy"
                                    
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
                                    
                                    self.timePromotion.text = "Từ ngày \(startTime) đến hết ngày \(endTime)"
                                    
                                    self.code.setTitle(data["Code"] as? String, for: .normal)

                                    do {
                                        let attrStr = try NSAttributedString(
                                            data: String((data["Content"] as? String)!).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                            options: [ .documentType: NSAttributedString.DocumentType.html],
                                            documentAttributes: nil)
                                        let font = UIFont(name: "Helvetica", size: 17.0)
                                        var height = self.content.heightForLabel(text: attrStr.string, font: font!, width: self.view.frame.width)
                                        self.heightEqual.constant = height
                                        self.content.attributedText = attrStr
                                    } catch let error {
                                        
                                    }
                                    
                                    self.imagePromotion.downloaded(from: (data["Picture1"]  as? String)!)
                                    self.imagePromotion.contentMode = .scaleAspectFill
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

    
    func showPromotion() {
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
        
        self.code.setTitle(self.data["Code"] as? String, for: .normal)

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
