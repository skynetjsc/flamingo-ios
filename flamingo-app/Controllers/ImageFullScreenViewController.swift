//
//  ImageFullScreenViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/7/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ImageFullScreenViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    
    var imageArr = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.frame = view.frame

        for i in 0..<imageArr.count {
            let imageView = UIImageView()
            imageView.downloaded(from: String(describing: imageArr[i]["Picture"]!))
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: -(self.navigationController?.navigationBar.frame.size.height)!, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            mainScrollView.addSubview(imageView)
        }
    }
    

}
