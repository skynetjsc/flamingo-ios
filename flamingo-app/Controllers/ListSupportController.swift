//
//  SupportListController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/18/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ListSupportController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SupportListController"
    }
    
    @IBAction func menuButtonDidClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
        
    }
    
}
