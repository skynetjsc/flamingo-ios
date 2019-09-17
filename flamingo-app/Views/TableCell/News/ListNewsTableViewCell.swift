//
//  ListNewsTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ListNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var viewborder: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageNews.layer.cornerRadius = 15
        imageNews.clipsToBounds = true
        if #available(iOS 11.0, *) {
            imageNews.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        viewborder.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            viewborder.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        viewborder.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
