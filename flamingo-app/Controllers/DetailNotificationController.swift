//
//  DetailNotification.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/18/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class DetailNotificationController: UIViewController {
    
    @IBOutlet weak var titleNotification: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var heightEqual: NSLayoutConstraint!
    @IBOutlet weak var contentNotificaiton: UILabel!
    @IBOutlet weak var imageNotification: UIImageView!
    
    var dataTitle: String?
    var dataContent: String?
    var dataNotifi = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "THÔNG BÁO"
    }
    
    @IBAction func menuButtonDidClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleNotification.text = self.dataNotifi["Title"] as? String
//        self.contentNotificaiton.text = self.dataContent
        
        do {
            let attrStr = try NSAttributedString(
                data: String((self.dataNotifi["Content"] as? String)!).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ .documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            
            let font = UIFont(name: "Helvetica", size: 17.0)
            var height = self.contentNotificaiton.heightForLabel(text: attrStr.string, font: font!, width: self.view.frame.width)
            self.heightEqual.constant = height
            self.contentNotificaiton.attributedText = attrStr
            self.imageNotification.downloaded(from: (self.dataNotifi["Picture1"]  as? String)!)
            self.imageNotification.contentMode = .scaleAspectFill
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
            if let datetime = dateFormatterGet.date(from: (self.dataNotifi["FromTime"] as? String)!) {
                
                
                self.time.text = dateFormatterPrint.string(from: datetime)
                
            }
        } catch let error {
            
        }
    }
    
}
