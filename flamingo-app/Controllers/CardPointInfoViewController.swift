//
//  CardPointInfoViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class CardPointInfoViewController: UIViewController {

    
    @IBOutlet weak var barCode: UIImageView!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var code: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
        print(userInfo)
        
        self.barCode.image = generateBarcode(from: userInfo["QRCode"] as! String)
        let newText = String((userInfo["QRCode"] as! String)
            .filter({ $0 != " " }).prefix(16))
        self.code.text = newText.chunkFormatted()
        
        
        let point = userInfo["Point"]!
        
        var textPoint = String(describing: point)
        if textPoint.elementsEqual("<null>") || textPoint.elementsEqual("") {
            textPoint = "0"
        }
        if Int(textPoint)! < 0 {
            textPoint = "0"
        }
        self.point.text = textPoint
        
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
        
        if !firstName.elementsEqual("") {
            self.name.text = "\(firstName) \(middleName) \(lastName)"
        } else {
            self.name.text = ""
        }
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }


}
