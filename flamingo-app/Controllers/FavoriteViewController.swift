//
//  FavoriteViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/2/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView
import SideMenuSwift

class FavoriteViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listFavorite = [[String: Any]]()
    var PropertyRoomID: String?
    @IBOutlet var viewParent: UIView!
    @IBOutlet var menuView: UIView!
    
    @IBOutlet weak var blurMenu: VisualEffectView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnFavoriteTap: UIButton!
    @IBOutlet weak var btnSeen: UIButton!
    @IBOutlet weak var btnSeenUnTap: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func showMenuLeft(_ sender: Any) {
        self.sideMenuController?.revealMenu()
    }
    
    @IBAction func home(_ sender: Any) {
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
    }
    
    @IBAction func setting(_ sender: Any) {
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetupContentNavigation")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
    }
    @IBAction func card(_ sender: Any) {
        self.performSegue(withIdentifier: "showCard", sender: nil)
    }
    
    func setupMenu(_ menuView: UIView) {
        let backgroundView = viewParent!
        menuView.frame = CGRect(x: 0, y: self.viewParent.frame.size.height-80, width: self.viewParent.frame.size.width, height: 135)
        self.blurMenu.colorTintAlpha = 0.2
        self.blurMenu.blurRadius = 2.8
        self.blurMenu.scale = 1
        self.blurMenu.clipsToBounds = true
        
        backgroundView.addSubview(menuView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.btnSeenUnTap.isHidden = true
        self.btnFavoriteTap.isHidden = true
        self.btnSeen.isHidden = false
        self.btnFavorite.isHidden = false
        
        self.setupMenu(menuView)
        self.getListFavorite()
        
    }
    
    func getListFavorite() {
        self.listFavorite = [[String:Any]]()
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "Username": currentUser["LoginName"]
            ] as [String : Any]
        self.showProgress()
        BaseService.shared.listFavorite(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        if let listFavorite = response["Data"]! as? [[String: Any]] {
                            self.listFavorite = listFavorite
                        }
                        
                        self.tableview.reloadData()
                    })
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    func getListSeen() {
        self.listFavorite = [[String:Any]]()
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "Username": currentUser["LoginName"]
            ] as [String : Any]
        self.showProgress()
        BaseService.shared.getSeenList(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        if let listFavorite = response["Data"]! as? [[String: Any]] {
                            self.listFavorite = listFavorite
                        }
                        
                        self.tableview.reloadData()
                    })
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.listFavorite.count)
        return self.listFavorite.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.isUserInteractionEnabled = true
        
//        cell.imageFavorite.downloaded(from: (self.listFavorite[indexPath.row]["Picture1"]  as? String)!)
//        cell.imagePromotion.contentMode = .scaleAspectFill
//        cell.title.text = self.listPromotion[indexPath.row]["Title"] as? String
//        cell.subtitle.text = self.listPromotion[indexPath.row]["Content"] as? String
//        cell.numberSalse.text = ""
        
        if let imageUrl = (self.listFavorite[indexPath.row]["Picture1"]  as? String) {
                cell.imageFavorite.downloaded(from: imageUrl)
        }
        cell.imageFavorite.contentMode = .scaleAspectFill
        
        cell.name.text = self.listFavorite[indexPath.row]["PropertyRoomName"] as? String
        cell.rating.rating = self.listFavorite[indexPath.row]["StarNum"] as? Double ?? 0
//        cell.price.text = String(describing: self.listFavorite[indexPath.row]["Price"]!)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "vi_VN")
        cell.price.text = numberFormatter.string(from: NSNumber(value: self.listFavorite[indexPath.row]["Price"] as! Double))!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//        self.dataContent = self.listNofitication[indexPath.row]["Content"] as? String
//        self.dataTitle = self.listNofitication[indexPath.row]["Title"] as? String
//        print(self.listFavorite[indexPath.row])
        
        self.PropertyRoomID = String(describing: self.listFavorite[indexPath.row]["ProperRoomID"]!)
        self.performSegue(withIdentifier: "showDetailRoom", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailRoom" {
            if let viewController: RoomDetailViewController = segue.destination as? RoomDetailViewController {
                let calendar = Calendar.current
                let nextTwoDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
                let nextOneDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
                let componentOne = calendar.dateComponents([.year, .month, .day], from: nextOneDate!)
                let componentTwo = calendar.dateComponents([.year, .month, .day], from: nextTwoDate!)
                
                viewController.PropertyRoomID = self.PropertyRoomID!
                viewController.valStartFormatDate = calendar.date(from:componentOne)
                viewController.valEndFormatDate = calendar.date(from:componentTwo)
            }
        }
    }
    
    @IBAction func clickFavorite(_ sender: Any) {
//        self.btnFavorite.backgroundColor = UIColor(red: 242/255, green: 94/255, blue: 28/255, alpha: 1)
//        self.btnFavorite.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//
//        self.btnFavorite.layer.borderWidth = 1
//        self.btnFavorite.layer.cornerRadius = 20
//        self.btnFavorite.layer.borderColor = UIColor(red: 242, green: 94, blue: 28, alpha: 1).cgColor
//
//        self.btnSeen.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        self.btnSeen.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        self.btnSeen.layer.borderWidth = 1
//        self.btnSeen.layer.cornerRadius = 20
//        self.btnSeen.layer.borderColor = UIColor(red: 242, green: 94, blue: 28, alpha: 1).cgColor
//        self.btnSeen.tintColor = UIColor(red: 242/255, green: 94/255, blue: 28/255, alpha: 1)
//
//        self.btnSeen.layer.masksToBounds = true
        
        
        self.getListFavorite()
    }
    
    
    @IBAction func clickSeen(_ sender: Any) {
//        self.btnSeen.backgroundColor = UIColor(red: 242/255, green: 94/255, blue: 28/255, alpha: 1)
//        self.btnSeen.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//
//        self.btnSeen.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        self.btnSeen.layer.borderWidth = 1
//        self.btnSeen.layer.cornerRadius = 20
//        self.btnSeen.layer.borderColor = UIColor(red: 242, green: 94, blue: 28, alpha: 1).cgColor
//
//
//
//        self.btnFavorite.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        self.btnFavorite.layer.borderWidth = 1
//        self.btnFavorite.layer.cornerRadius = 20
//        self.btnFavorite.layer.borderColor = UIColor(red: 242, green: 94, blue: 28, alpha: 1).cgColor
        
        
        self.btnSeenUnTap.isHidden = false
        self.btnFavoriteTap.isHidden = false
        self.btnSeen.isHidden = true
        self.btnFavorite.isHidden = true
        
        self.getListSeen()
    }
    
    
    @IBAction func favoriteTap(_ sender: Any) {
        self.btnSeenUnTap.isHidden = true
        self.btnFavoriteTap.isHidden = true
        self.btnSeen.isHidden = false
        self.btnFavorite.isHidden = false
        self.getListFavorite()
    }
    
    
}
