//
//  LastBookCollection.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/23/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class LastBookCollection: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func awakeFromNib() {
        self.dataSource = self
        self.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastBookCollectionViewCell", for: indexPath) as! LastBookCollectionViewCell
        
        return cell
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
