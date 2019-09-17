//
//  FavoritesController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/20/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FavoritesController"
    }
    
    @IBAction func menuButtonDidClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
}
