//
//  BôkModalViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/24/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView

class BookModalViewController: UIViewController {

//    @IBOutlet weak var bgEffect: VisualEffectView!
//    @IBOutlet weak var bgEffectCountPeople: VisualEffectView!
//
//    @IBOutlet weak var bgNumberRoom: VisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Set Background
//        bgEffect.colorTintAlpha = 0.7
//        bgEffect.blurRadius = 3
//        bgEffect.scale = 1
////        visualEffectFormSearch.clipsToBounds = true
////
////        visualEffectFormSearch.layer.cornerRadius = 25
//        
//        bgNumberRoom.colorTintAlpha = 0.7
//        bgNumberRoom.blurRadius = 4
//        bgNumberRoom.scale = 1
//        bgNumberRoom.clipsToBounds = true
//        bgNumberRoom.layer.cornerRadius = 15
//        
//        
//        bgEffectCountPeople.colorTintAlpha = 0.7
//        bgEffectCountPeople.blurRadius = 4
//        bgEffectCountPeople.scale = 1
//        bgEffectCountPeople.clipsToBounds = true
//        bgEffectCountPeople.layer.cornerRadius = 15
        
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
