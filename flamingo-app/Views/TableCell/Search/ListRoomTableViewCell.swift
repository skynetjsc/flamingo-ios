//
//  ListRoomTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/23/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import Cosmos
import VisualEffectView

class ListRoomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countRate: UILabel!
    @IBOutlet weak var tapViewLike: UIView!
    @IBOutlet weak var icon_like: UIImageView!
    @IBOutlet weak var blurLike: VisualEffectView!
    @IBOutlet weak var blurRate: VisualEffectView!
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var priceItem: UILabel!
    @IBOutlet weak var ratingItem: CosmosView!
    @IBOutlet weak var locationItem: UILabel!
    @IBOutlet weak var countDay: UILabel!
    
    @IBOutlet weak var borderItemBottom: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderItemBottom.layer.cornerRadius = 15
        borderItemBottom.clipsToBounds = true
        if #available(iOS 11.0, *) {
            borderItemBottom.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        self.blurLike.colorTintAlpha = 0.2
        self.blurLike.blurRadius = 13
        self.blurLike.layer.cornerRadius = 18
        self.blurLike.scale = 1
        self.blurLike.clipsToBounds = true
        
        
        self.blurRate.colorTintAlpha = 0.2
        self.blurRate.blurRadius = 1
        self.blurRate.layer.cornerRadius = 12
        self.blurRate.scale = 1
        self.blurRate.clipsToBounds = true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
