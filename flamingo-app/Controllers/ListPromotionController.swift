//
//  ListPromotionController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/18/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class ListPromotionController: BaseViewController,  UITableViewDelegate, UITableViewDataSource{
    
    var listPromotion = [[String: Any]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "KHUYẾN MÃI"
        
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
                        
                        self.tableView.reloadData()
                    })
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    @IBAction func menuButtonDidClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPromotion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionViewCell", for: indexPath) as! PromotionViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.isUserInteractionEnabled = true
        cell.imagePromotion.downloaded(from: (self.listPromotion[indexPath.row]["Picture1"]  as? String)!)
        cell.imagePromotion.contentMode = .scaleAspectFill
        cell.title.text = self.listPromotion[indexPath.row]["Title"] as? String
//        cell.subtitle.text = self.listPromotion[indexPath.row]["Content"] as? String
        do {
            let attrStr = try NSAttributedString(
                data: String((self.listPromotion[indexPath.row]["Content"] as? String)!).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ .documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            cell.subtitle.attributedText = attrStr
        } catch let error {
            
        }
        cell.numberSalse.text = ""
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailPromotionController") as! DetailPromotionViewController
        controller.data = self.listPromotion[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func home(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CustomerController") as! NavigationController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
}


class PromotionViewCell: UITableViewCell {
    
    @IBOutlet weak var imagePromotion: UIImageView!
    @IBOutlet weak var numberSalse: UILabel!
    @IBOutlet weak var bgBottom: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    
}
