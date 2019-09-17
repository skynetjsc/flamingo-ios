//
//  HeaderTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/24/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import Cosmos

class HeaderTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var collectionViewUltilities: UICollectionView!
    @IBOutlet weak var collectionViewPicture: UICollectionView!
    
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var priceItem: UILabel!
    @IBOutlet weak var reviewItem: CosmosView!
    @IBOutlet weak var countVote: UILabel!
    @IBOutlet weak var sizeItem: UILabel!
    @IBOutlet weak var countDay: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var noteRate: UILabel!
    @IBOutlet weak var nameRate: UILabel!
    
    @IBOutlet weak var moreRate: UIButton!
    
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var noteItem: UILabel!
    
    var dataListPictures = [[String: Any]]()
    var dataListUtilities = [[String: Any]]()
    
    var showImage: (() -> (Void))!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewPicture.dataSource = self
        collectionViewPicture.delegate = self
        
        collectionViewUltilities.delegate = self
        collectionViewUltilities.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewUltilities {
                return self.dataListUtilities.count
        } else if collectionView == collectionViewPicture {
            return self.dataListPictures.count
        }
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.collectionViewUltilities {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UtilitiesCollectionViewCell", for: indexPath) as! UtilitiesCollectionViewCell
            if !String(describing: self.dataListUtilities[indexPath.row]["Picture"]!).elementsEqual("<null>") {
                
                    cell.imageUtilities.downloaded(from: (self.dataListUtilities[indexPath.row]["Picture"] as? String)!)
            }
            
            cell.imageUtilities.contentMode = .scaleAspectFill
            cell.titleUtilities.text = self.dataListUtilities[indexPath.row]["Name"] as? String
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath) as! PictureCollectionViewCell
            cell.imagePicture.downloaded(from: (self.dataListPictures[indexPath.row]["Picture"] as? String)!)
            cell.imagePicture.contentMode = .scaleAspectFill
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewPicture {
            showImage()
        }
    }
    

}
