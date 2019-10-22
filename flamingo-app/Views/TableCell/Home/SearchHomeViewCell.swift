//
//  SearchHomeViewCell.swift
//  flamingo-app
//
//  Created by Nguyễn Chí Thành on 8/20/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView

class SearchHomeViewCell: UITableViewCell {

    @IBOutlet weak var visualEffectFormSearch: VisualEffectView!
    @IBOutlet weak var btnFormSearch: UIButton!
    
    @IBOutlet weak var txtStartDate: UILabel!
    @IBOutlet weak var txtSearch: TextField!
    
    @IBOutlet weak var txtEnDate: UILabel!
    
    @IBOutlet weak var viewListReceipt: UIView!
    @IBOutlet weak var viewShowReciptDetail: UIView!
    
    @IBOutlet weak var point: UILabel!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        visualEffectFormSearch.colorTintAlpha = 0.2
        visualEffectFormSearch.blurRadius = 2
        visualEffectFormSearch.scale = 1
        visualEffectFormSearch.clipsToBounds = true
        
        visualEffectFormSearch.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
