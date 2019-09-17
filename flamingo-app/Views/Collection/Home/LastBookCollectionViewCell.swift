//
//  LastBookCollectionViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/23/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView
import Cosmos

class LastBookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgTitle: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: CosmosView!
    
    @IBOutlet weak var blurLike: VisualEffectView!
    
    
    override func awakeFromNib() {
        bgTitle.layer.cornerRadius = 15
        bgTitle.clipsToBounds = true
        if #available(iOS 11.0, *) {
            bgTitle.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        self.blurLike.colorTintAlpha = 0.2
        self.blurLike.blurRadius = 13
        self.blurLike.layer.cornerRadius = 13
        self.blurLike.scale = 1
        self.blurLike.clipsToBounds = true
    }
}
