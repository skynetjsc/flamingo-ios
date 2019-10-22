//
//  FlashSalesTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/28/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var data = [[String: Any]]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    var callback: (([String: Any]) -> (Void))!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsHomeCollectionViewCell", for: indexPath) as! NewsHomeCollectionViewCell
        if self.data[indexPath.row]["Picture1"]  as? String != nil {
            cell.bgItem.downloaded(from: (self.data[indexPath.row]["Picture1"]  as? String)!)
        }
        
        cell.bgItem.contentMode = .scaleAspectFill
        cell.titleItem.text = self.data[indexPath.row]["Title"] as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.callback?(data[indexPath.row])
    }

}
