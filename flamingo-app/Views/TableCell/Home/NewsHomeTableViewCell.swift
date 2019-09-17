//
//  NewsHomeTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class NewsHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var viewNews: UIView!
    
    
    
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

        viewNews.layer.cornerRadius = 15
        if #available(iOS 11.0, *) {
            viewNews.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        viewNews.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
