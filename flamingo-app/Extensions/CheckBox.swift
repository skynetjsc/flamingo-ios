//
//  CheckBox.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/29/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    let checkedImage = UIImage(named: "checked")
    let unCheckedImage = UIImage(named: "uncheck")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
                self.tintColor = UIColor(red: 242/255, green: 94/255, blue: 28/255, alpha: 1)
            } else {
                self.setImage(unCheckedImage, for: .normal)
                self.tintColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonCheck(_:)), for: .touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonCheck(_ sender: UIButton) {
        if (sender == self) {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
}
