//
//  CustomerPromotionViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/1/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift

class CustomerPromotionViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var listPromotion = [[String: Any]]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "ƯU ĐÃI"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getListPromotion()
    }
    
    func getListPromotion() {
        let params = [String: Any]()
        BaseService.shared.listPromotion(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        if let listPromotion = response["Data"]! as? [[String: Any]] {
                            self.listPromotion = listPromotion
                        }
                        self.collectionView.reloadData()
                        
                    })
                    
                    
                    
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listPromotion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionCollectionCell", for: indexPath) as! PromotionCollectionCell

        
        cell.imagePromotion.downloaded(from: (self.listPromotion[indexPath.row]["Picture1"]  as? String)!)
        cell.imagePromotion.contentMode = .scaleAspectFill
        cell.titlePromotion.text = self.listPromotion[indexPath.row]["Title"] as? String
        cell.subtilePromotion.text = self.listPromotion[indexPath.row]["Content"] as? String
        cell.txtNumberSale.text = ""
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailPromotionController") as! DetailPromotionViewController
        //        controller.selectedIndex = indexPath.row
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func backButton(_ sender: Any) {
        
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
    }
    
    
}
