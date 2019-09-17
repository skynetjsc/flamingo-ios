//
//  TrackCollectionViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/31/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var imageStatus: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var time: UILabel!
    
}
