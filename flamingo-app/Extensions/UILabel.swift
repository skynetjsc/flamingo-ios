//
//  UILabel.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/13/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import Foundation

extension UILabel {
    
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
}
