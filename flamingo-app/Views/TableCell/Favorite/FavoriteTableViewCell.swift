//
//  FavoriteTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import Cosmos

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageFavorite: UIImageView!
    @IBOutlet weak var bgBottom: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var countDay: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: CosmosView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgBottom.layer.cornerRadius = 15
        bgBottom.clipsToBounds = true
        if #available(iOS 11.0, *) {
            bgBottom.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
