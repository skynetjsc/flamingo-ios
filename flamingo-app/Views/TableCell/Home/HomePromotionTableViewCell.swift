//
//  HomePromotionTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/3/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class HomePromotionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var data = [[String: Any]]()
    var callback: (([String: Any]) -> (Void))!
    
    @IBOutlet weak var viewAllPromotion: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePromotionCollectionViewCell", for: indexPath) as! HomePromotionCollectionViewCell
        
        cell.imagePromotion.downloaded(from: (data[indexPath.row]["Picture1"]  as? String)!)
        cell.imagePromotion.contentMode = .scaleAspectFill
        cell.title.text = data[indexPath.row]["Title"] as? String
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(data[indexPath.row])
    }

}
