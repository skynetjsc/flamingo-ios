//
//  IntroduceController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/18/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class IntroduceController: UIViewController {
    
    
    @IBOutlet weak var txtIntroduce: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.awakeFromNib()
        title = "GIỚI THIỆU"
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        txtIntroduce.attributedText = NSAttributedString(string: txtIntroduce.text, attributes: attributes)
    }
    
    
    @IBAction func menuButtonDidClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
