//
//  TearmViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class RulesController: BaseViewController {

    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ĐIỀU KHOẢN"

//        self.content.text = "Lorem Ipsum chỉ đơn giản là một đoạn văn bản giả, được dùng vào việc trình bày và dàn trang phục vụ cho in ấn. Lorem Ipsum đã được sử dụng như một văn bản chuẩn cho ngành công nghiệp in ấn từ những năm 1500, khi một họa sĩ vô danh ghép nhiều đoạn văn bản với nhau để tạo thành một bản mẫu văn bản.Đoạn văn bản này không những đã tồn tại năm thế kỉ, mà khi được áp dụng vào tin học văn phòng, nội dung của nó vẫn không hề bị thay đổi. Nó đã được phổ biến trong những năm 1960 nhờ việc bán những bản giấy Letraset in những đoạn Lorem Ipsum, và gần đây hơn, được sử dụng trong các ứng dụng dàn trang, như Aldus PageMaker."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let params = [
            "KeyName": "DK01"
            ] as [String : Any]
        self.showProgress()
        BaseService.shared.ruleConfigByKey(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                if let _ = response["Data"]{
                    let contentStr = response["Data"]!["KeyValue"] as! String
                    do {
                        let attrStr = try NSAttributedString(
                            data: contentStr.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                            options: [ .documentType: NSAttributedString.DocumentType.html],
                            documentAttributes: nil)
                        let font = UIFont(name: "Helvetica", size: 17.0)

                        self.content.attributedText = attrStr
                        
                    } catch let error {
                        
                    }

                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
        
    }
    


}
