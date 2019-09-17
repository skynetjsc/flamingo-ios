//
//  FlashSalesCollectionViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/28/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import MarqueeLabel

class FlashSalesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgItem: UIImageView!
    
    @IBOutlet weak var titleScroll: MarqueeLabel!
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var bgTitle: UIView!
    
    override func awakeFromNib() {
        bgTitle.layer.cornerRadius = 15
        bgTitle.clipsToBounds = true
        if #available(iOS 11.0, *) {
            bgTitle.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
//        titleScroll.tag = 501
        titleScroll.type = .continuous
        titleScroll.speed = .duration(10)
        titleScroll.fadeLength = 10.0
        titleScroll.trailingBuffer = 30.0

        
    }
}
