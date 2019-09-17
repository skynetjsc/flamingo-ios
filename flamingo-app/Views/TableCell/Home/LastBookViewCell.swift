//
//  LastBookViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/23/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class LastBookViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = [[String: Any]]()
    var callback: ((String) -> (Void))!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        self.backgroundColor = .clear
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastBookCollectionViewCell", for: indexPath) as! LastBookCollectionViewCell
        
        cell.bgImage.downloaded(from: (self.data[indexPath.row]["Picture1"]  as? String)!)
        cell.bgImage.contentMode = .scaleAspectFill
        cell.title.text = self.data[indexPath.row]["PropertyRoomName"] as? String
        cell.rating.rating = self.data[indexPath.row]["StarNum"] as! Double
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let PropertyRoomID = "\(String(describing: self.data[indexPath.row]["PropertyRoomID"]!))"
        self.callback?(PropertyRoomID)
    }
    
    
}
