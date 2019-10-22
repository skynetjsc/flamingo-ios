//
//  CustomerController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/18/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift

class CustomerController: BaseViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    var backgroundView: UIImageView!
    var offsetBackground = CGFloat(0)
    
    var data = [String: Any]()
    var dataNews = [String: Any]()
    
    var listNews = [[String: Any]]()
    var listPromotion = [[String: Any]]()
    
    @IBOutlet weak var itemScan: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.updateUI()
        self.registerCell()
        title = "custom"
//        self.view.backgroundColor = .white
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backNav(_:)))
//        self.navigationItem.leftBarButtonItem = newBackButton
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        itemScan.isUserInteractionEnabled = true
        itemScan.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer)
    {
        
        self.performSegue(withIdentifier: "CardPointInfoViewController", sender: nil)
    }
    
    //MARK: Methods
    func registerCell(){
        self.offsetBackground = self.navigationController?.navigationBar.frame.size.height ?? 0 + UIApplication.shared.statusBarFrame.height
        
    }
    func setupUI(){
        let screenSize = UIScreen.main.bounds.size
        self.backgroundView = UIImageView(frame: CGRect(x: 0, y: -self.offsetBackground, width: screenSize.width, height: 250))
        self.backgroundView.image = UIImage(named: "bg.png")
        self.backgroundView.contentMode = .scaleAspectFill
        self.scrollView.addSubview(self.backgroundView)
        self.scrollView.sendSubviewToBack(self.backgroundView)
        self.scrollView.delegate = self
    }
   
    func updateUI(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.gray
    }
    
    
    
    @IBAction func menuButtonDidClicked(_ sender: Any) {
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
    }
    
    @IBAction func promotion(_ sender: Any) {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PromotionNavigation") as! NavigationController
//        UIApplication.shared.keyWindow?.rootViewController = viewController
        
        self.performSegue(withIdentifier: "ListPromotion", sender: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getListNews()
        self.getListPromotion()
        self.tableView.backgroundColor = .clear
        
        let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 0)
        self.tableView.backgroundColor = color
        
        //                self.backgroundView.backgroundColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        self.backgroundView.image = UIImage(named: "bg")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 0)
        self.tableView.backgroundColor = color
        
        //                self.backgroundView.backgroundColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        self.backgroundView.image = UIImage(named: "bg")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let offset = 1
        let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        //        let navigationcolor = UIColor.init(hue: 0, saturation: CGFloat(offset), brightness: 1, alpha: 1)
        self.tableView.backgroundColor = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    
    @IBAction func notification(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//        guard let navigationController = sideMenuController?.contentViewController as? UINavigationController else {
//            return
//        }
//        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "NotificationController") as? NavigationController else {
//            return
//        }
//        navigationController.present(viewController, animated: true, completion: nil)
        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "NotificationController") as! NavigationController
//        UIApplication.shared.keyWindow?.rootViewController = viewController
        self.performSegue(withIdentifier: "showListNotification", sender: nil)
    }
    
    @IBAction func user(_ sender: Any) {
        self.performSegue(withIdentifier: "UserInfo", sender: nil)
    }
    
    func getListPromotion() {
        let params = [String: Any]()
        BaseService.shared.listPromotion(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
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
    
    func getListNews() {
        let params = [
            "NewTypeID": "1"
        ]
        BaseService.shared.listNews(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        if let listNews = response["Data"]! as? [[String: Any]] {
                            self.listNews = listNews
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
    
    @IBAction func goToScan(_ sender: Any) {
        
        self.performSegue(withIdentifier: "CardPointInfoViewController", sender: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let offset = 1
        let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        //        let navigationcolor = UIColor.init(hue: 0, saturation: CGFloat(offset), brightness: 1, alpha: 1)
//        self.tableView.backgroundColor = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationController?.navigationBar.barStyle = .default
        
    }
    
}

extension CustomerController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.listNews.count + 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCustomerTableViewCell") as! HeaderCustomerTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(viewAllPromotion(_:)))
            cell.couponView.isUserInteractionEnabled = true
            cell.couponView.addGestureRecognizer(tap)
            
            let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
            
            let point = userInfo["Point"]!
            print(point)
            var textPoint = String(describing: point)
            if textPoint.elementsEqual("<null>") || textPoint.elementsEqual("") {
                textPoint = "0"
            }
//            if Int(textPoint)! < 0 {
//                textPoint = "0"
//            }
            
            cell.point.text = Int(textPoint)?.formattedWithSeparator
            
            let tapReciept = UITapGestureRecognizer(target: self, action: #selector(viewAllReciept(_:)))
            cell.reciept.isUserInteractionEnabled = true
            cell.reciept.addGestureRecognizer(tapReciept)

            return cell
        }  else  if row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomePromotionTableViewCell") as! HomePromotionTableViewCell
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(viewAllPromotion(_:)))
            cell.viewAllPromotion.isUserInteractionEnabled = true
            cell.viewAllPromotion.addGestureRecognizer(tap)
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.isUserInteractionEnabled = true
            
            cell.callback = { recived in
                self.data = recived
                self.performSegue(withIdentifier: "DetailPromotion", sender: nil)
            }
            
            

            cell.data = self.listPromotion
            cell.collectionView.reloadData()
            
            return cell
            
        }else if row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleHomeTableViewCell") as! TitleHomeTableViewCell
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(viewAllNews(_:)))
            cell.viewAll.isUserInteractionEnabled = true
            cell.viewAll.addGestureRecognizer(tap)
            
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomeTableViewCell") as! NewsHomeTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.isUserInteractionEnabled = true
            cell.imageNews.downloaded(from: (self.listNews[indexPath.row - 3]["Picture1"]  as? String)!)
            cell.imageNews.contentMode = .scaleAspectFill
            cell.dateNews.text = ""
//            cell.subtitle.text = self.listNews[indexPath.row - 3]["Content"] as? String
            cell.titleNews.text = self.listNews[indexPath.row - 3]["Title"] as? String
            if self.listNews[indexPath.row - 3]["Content"] as? String != nil {
                do {
                    let attrStr = try NSAttributedString(
                        data: String((self.listNews[indexPath.row - 3]["Content"] as? String)!).data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                        options: [ .documentType: NSAttributedString.DocumentType.html],
                        documentAttributes: nil)
                    cell.subtitle.attributedText = attrStr
                } catch let error {
                    
                }
            }
           
            
            return cell
        }
        
    }
    @objc func viewAllNews(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "ListNews", sender: nil)
    }
    
    @objc func viewAllReciept(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "ListReciept", sender: nil)
    }
    
    @objc func viewAllPromotion(_ sender: UITapGestureRecognizer) {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PromotionNavigation") as! NavigationController
//        UIApplication.shared.keyWindow?.rootViewController = viewController

        self.performSegue(withIdentifier: "ListPromotion", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListNews" {
            if let viewController: ListNewsViewController = segue.destination as? ListNewsViewController {
                viewController.listNews = self.listNews
            }
        } else if segue.identifier == "DetailPromotion" {
            if let viewController: DetailPromotionViewController = segue.destination as? DetailPromotionViewController {
                viewController.data = self.data
            }
        } else if segue.identifier == "DetailNews" {
            if let viewController: DetailNewsViewController = segue.destination as? DetailNewsViewController {
                viewController.data = self.dataNews
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            self.tableViewHeight.constant = self.tableView.contentSize.height + 150
            self.view.layoutIfNeeded()
            return 150
        } else if indexPath.row == 1{
            self.tableViewHeight.constant = self.tableView.contentSize.height + 230
            self.view.layoutIfNeeded()
            return 230
        } else if indexPath.row == 2{
            self.tableViewHeight.constant = self.tableView.contentSize.height + 50
            self.view.layoutIfNeeded()
            return 50
        } else {
            self.tableViewHeight.constant = self.tableView.contentSize.height + 120
            self.view.layoutIfNeeded()
            return 120
        }
//        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row >= 3) {
            self.dataNews = self.listNews[indexPath.row - 3]
            self.performSegue(withIdentifier: "DetailNews", sender: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = self.scrollView.contentOffset.y + self.offsetBackground
        var offset = y / self.offsetBackground
        
        if y - 20 > self.offsetBackground {
            
            //Set logo
//            let logo = UIImage(named: "logo_home_orange")
//            let imageView = UIImageView(image:logo)
//            self.navigationItem.titleView = imageView
            
            self.navigationItem.title = "Xin chào!"
            
            UIView.animate(withDuration: 0.2, animations: {
                offset = 1
                let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: offset)
                let navigationcolor = UIColor.init(hue: 0, saturation: offset, brightness: 1, alpha: 1)
                self.backgroundView.image = nil
                self.tableView.backgroundColor = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: offset)
                self.navigationController?.navigationBar.tintColor = UIColor.gray
                self.navigationController?.navigationBar.backgroundColor = color
//                UIApplication.shared.statusBarView?.backgroundColor = color
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationcolor]
                self.navigationController?.navigationBar.barStyle = .default
            })
        } else {
            let yImageView = min(-self.offsetBackground*2, y-self.offsetBackground)
            var frameImage = self.backgroundView.frame
            frameImage.origin.y = yImageView
            self.backgroundView.frame = frameImage
            //Set logo
//            let logo = UIImage(named: "logo_home_white")
//            let imageView = UIImageView(image:logo)
//            self.navigationItem.titleView = imageView

            self.navigationItem.title = "Xin chào!"
            
            UIView.animate(withDuration: 0.2, animations: {
                let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: offset - 4)
                self.tableView.backgroundColor = color
                
                //                self.backgroundView.backgroundColor = color
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.backgroundColor = color
//                UIApplication.shared.statusBarView?.backgroundColor = color
                self.backgroundView.image = UIImage(named: "bg")
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.barStyle = .black
            })
        }
    }
    
    
    
    
}
