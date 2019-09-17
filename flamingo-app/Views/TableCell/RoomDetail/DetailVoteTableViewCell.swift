//
//  DetailVoteTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/4/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import Cosmos

class DetailVoteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateVote: UILabel!
    @IBOutlet weak var starVote: CosmosView!
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var start: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
