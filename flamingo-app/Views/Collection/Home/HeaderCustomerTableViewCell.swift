//
//  HeaderCustomerTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class HeaderCustomerTableViewCell: UITableViewCell {

    var data = [String: Any]()
    
    @IBOutlet weak var couponView: UIView!
    
    @IBOutlet weak var reciept: UIView!
    
    @IBOutlet weak var point: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
