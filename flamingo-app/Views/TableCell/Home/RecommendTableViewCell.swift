//
//  RecommendTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/23/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

protocol MyDelegate {
    func goToDetailDelegate(_ PropertyID: String)
}

class RecommendTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var delegate: MyDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var callback: ((String) -> (Void))!
    
    
    var data = [[String: Any]]()
    var PropertyID: String?
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as! RecommendCollectionViewCell
//        print(self.data[indexPath.row]["Picture1"]  as? String)
//        cell.bgImage.downloaded(from: (self.data[indexPath.row]["Picture1"]  as? String)!)
        
        cell.bgImage.downloaded(from: (self.data[indexPath.row]["Picture1"]  as? String)!)
        cell.bgImage.contentMode = .scaleAspectFill
        cell.title.text = self.data[indexPath.row]["Name"] as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.PropertyID = String(describing: self.data[indexPath.row]["ID"]!)
        self.callback?(self.PropertyID!)
    }
    
    

}
