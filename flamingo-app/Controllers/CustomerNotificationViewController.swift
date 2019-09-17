//
//  ListNotificationController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/18/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift

class CustomerNotificationViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var listNofitication = [[String: Any]]()
    
    var dataTitle: String?
    var dataContent: String?
    var dataNotifi = [String: Any]()
    
//    @IBOutlet weak var notificaitonCollectionView: UICollectionView!
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "THÔNG BÁO"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getListNews()
    }
    
    func getListNews() {
        let params = [
            "NewTypeID": "2"
        ]
        BaseService.shared.listNews(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        if let listNofitication = response["Data"]! as? [[String: Any]] {
                            self.listNofitication = listNofitication
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
    
    
//    @IBAction func menuButtonDidClicked(_ sender: Any) {
//        //        dismiss(animated: true, completion: nil)
//        //        navigationController?.popViewController(animated: true)
//        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
//        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
//        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
//        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listNofitication.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.isUserInteractionEnabled = true
        
        print(self.listNofitication[indexPath.row])
        
        cell.imageIb.image = UIImage(named: "ic_noti_recieved")
        cell.title.text = self.listNofitication[indexPath.row]["Title"] as? String
//        cell.subTitle.text = self.listNofitication[indexPath.row]["Content"] as? String
        do {
            let attrStr = try NSAttributedString(
                data: String((self.listNofitication[indexPath.row]["Content"] as? String)!).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ .documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            cell.subTitle.attributedText = attrStr
        } catch let error {
            
        }
        var dateVote = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
        if let datetime = dateFormatterGet.date(from: (self.listNofitication[indexPath.row]["FromTime"] as? String)!) {
            
            dateVote = dateFormatterPrint.string(from: datetime)
            print(dateVote)
        }
        cell.dateNotification.text = dateVote
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dataContent = self.listNofitication[indexPath.row]["Content"] as? String
        self.dataTitle = self.listNofitication[indexPath.row]["Title"] as? String
        self.dataNotifi = self.listNofitication[indexPath.row]
        self.performSegue(withIdentifier: "DetailNotificationController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailNotificationController" {
            if let viewController: DetailNotificationController = segue.destination as? DetailNotificationController {
//                viewController.dataTitle = self.dataTitle!
//                viewController.dataContent = self.dataContent!
                viewController.dataNotifi = self.dataNotifi
            }
        }
    }
    
    
}
