//
//  AccountDetailReceiptTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class AccountDetailReceiptTableViewCell: UITableViewCell {

    @IBOutlet weak var receiptID: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var title: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
