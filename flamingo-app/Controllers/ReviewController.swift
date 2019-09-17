//
//  ReviewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/18/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ReviewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ReviewController"
    }
    
    @IBAction func menuButtonDidClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
}
