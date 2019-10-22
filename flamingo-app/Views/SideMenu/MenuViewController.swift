//
//  MenuViewController.swift
//  SideMenuExample
//
//  Created by kukushi on 11/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit
import SideMenuSwift

class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}

class MenuViewController: BaseViewController {
    var isDarkModeEnabled = false
    
//    let section = ["TÀI KHOẢN", "KHÁCH SẠN", "HỆ THỐNG", "NGÔN NGỮ & TIỀN TỆ", "QUẦY THÔNG TIN"]
    let section = ["TÀI KHOẢN", "KHÁCH SẠN", "HỆ THỐNG"]
    
//    var items = [["TRẦN THANH TUẤN", "Hạng Chuẩn", "Quản lý thành viên"], ["Trang chủ", "Theo dõi đặt phòng", "Đánh giá của tôi", "Khách sạn yêu thích"], ["Thông báo", "Tin khuyến mãi"], ["Ngôn ngữ","Mệnh giá", "(024) 7304 6669"], ["Giới thiệu", "Đánh giá", "Hỗ trợ"]]
    var items = [["TRẦN THANH TUẤN", "Hạng Chuẩn", "Quản lý thành viên"], ["Trang chủ", "Theo dõi đặt phòng", "Đánh giá của tôi", "Khách sạn yêu thích"], ["Thông báo", "Tin khuyến mãi"]]
    
    let listMenu = ["TÀI KHOẢN", "TRẦN THANH TUẤN", "Hạng Chuẩn", "Quản lý thành viên", "KHÁCH SẠN", "Trang chủ", "Theo dõi đặt phòng", "Đánh giá của tôi", "Khách sạn yêu thích", "Khách sạn đã xem", "HỆ THỐNG", "Thông báo", "Tin khuyến mãi", "NGÔN NGỮ & TIỀN TỆ", "Ngôn ngữ","Mệnh giá", "QUẦY THÔNG TIN", "Giới thiệu", "Đánh giá", "Hỗ trợ"
    ]
    
    @IBOutlet weak var avatarUser: UIImageView!
    
    var name: String?
    var avatar: String?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var selectionTableViewHeader: UILabel!

    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
    private var themeColor = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()
        App.shared.save(value: "TRUE" as AnyObject, forKey: "RELOAD")
        isDarkModeEnabled = SideMenuController.preferences.basic.position == .under
        
        
        configureView()

        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "CustomerController")
        }, with: "02")

        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "ContentNavigation")
        }, with: "10")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "TrackBookController")
        }, with: "11")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "ListVoteController")
        }, with: "12")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "FavoritesController")
        }, with: "13")
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "SupportController")
        }, with: "14")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "NotificationController")
        }, with: "20")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "PromotionController")
        }, with: "21")
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "LangContentNavigation")
        }, with: "30")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "MoneyContentNavigation")
        }, with: "31")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "IntroduceController")
        }, with: "40")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "ReviewController")
        }, with: "41")
        
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "SupportController")
        }, with: "42")

        sideMenuController?.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showUser(_:)))
        self.avatarUser.addGestureRecognizer(tapGesture)
        self.avatarUser.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let token = App.shared.getStringAnyObject(key: K_CURRENT_USER)
//        if token["access_token"] != nil {
//            
//            
//        }
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if userInfo["ID"] != nil {
            self.getUserInfo()
        }
        
    }
    
    @objc func showUser(_ sender: UITapGestureRecognizer) {
        
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if userInfo["ID"] != nil {
            
            self.performSegue(withIdentifier: "showDetailUser", sender: nil)
        } else {
            var refreshAlert = UIAlertController(title: "Thông báo", message: "Vui lòng đăng nhập để sử dụng chức năng", preferredStyle: UIAlertController.Style.alert)
                            
                refreshAlert.addAction(UIAlertAction(title: "Đăng nhập", style: .default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                    self.performSegue(withIdentifier: "showLogin", sender: nil)
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    
    func getUserInfo() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "ID": currentUser["ID"]
            ] as [String : Any]
        BaseService.shared.getUserInfo(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                        App.shared.save(value: response["Data"] as AnyObject, forKey: "USER_INFO")
                        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
//                        print(userInfo)
                        var fName = userInfo["FirstName"]!
                        var firstName = String(describing: fName)
                        if firstName.elementsEqual("<null>") || firstName.elementsEqual("") {
                            firstName = "  "
                        }
                        
                        var lName = userInfo["LastName"]!
                        var lastName = String(describing: lName)
                        if lastName.elementsEqual("<null>") || lastName.elementsEqual("") {
                            lastName = "  "
                        }
                        
                        var mName = userInfo["MiddleName"]!
                        var middleName = String(describing: mName)
                        if middleName.elementsEqual("<null>") || middleName.elementsEqual("") {
                            middleName = "   "
                        }
                        var avtPath = userInfo["AvatarPath"]!
                        var avatar = String(describing: avtPath)
                        if !avatar.elementsEqual("<null>") && !avatar.elementsEqual("") {
                            self.avatarUser.downloaded(from: avatar)
                        }
                        
                        
                        
                        self.name = "\(firstName) \(middleName) \(lastName)"
                        self.items[0][0] = "\(firstName) \(middleName) \(lastName)"
                        
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

    private func configureView() {
        if isDarkModeEnabled {
            themeColor = UIColor(red: 0.03, green: 0.04, blue: 0.07, alpha: 1.00)
            selectionTableViewHeader.textColor = .white
        } else {
            selectionMenuTrailingConstraint.constant = 0
            themeColor = UIColor(red: 0.98, green: 0.97, blue: 0.96, alpha: 1.00)
        }

        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        if showPlaceTableOnLeft {
            selectionMenuTrailingConstraint.constant = SideMenuController.preferences.basic.menuWidth - view.frame.width
        }
        view.backgroundColor = themeColor
        tableView.backgroundColor = themeColor
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
        view.layoutIfNeeded()
    }
}

extension MenuViewController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }

    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }

    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }

    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will hide")
    }

    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did hide.")
    }

    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will reveal.")
    }

    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did reveal.")
    }
    
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let label = UILabel()
        label.text = self.section[section]
        label.frame = CGRect(x: 24, y: 0, width: 200, height: 20)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
//        label.font = label.font.withSize(12)
//        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.darkGray
        headerView.addSubview(label)
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    

    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectionCell
        cell.contentView.backgroundColor = themeColor
//        let row = indexPath.row
        if (indexPath.section == 0 && indexPath.row == 0) {
//            let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
//            if let user: [String: Any] = userInfo {
//                var fName = user["FirstName"]!
//                var firstName = String(describing: fName)
//                if firstName.elementsEqual("<null>") || firstName.elementsEqual("") {
//                    firstName = ""
//                }
//
//                var lName = user["LastName"]!
//                var lastName = String(describing: lName)
//                if lastName.elementsEqual("<null>") || lastName.elementsEqual("") {
//                    lastName = ""
//                }
//
//                var mName = user["MiddleName"]!
//                var middleName = String(describing: mName)
//                if middleName.elementsEqual("<null>") || middleName.elementsEqual("") {
//                    middleName = ""
//                }
//
//                if !firstName.elementsEqual("") {
//                    cell.titleLabel?.text = "\(firstName) \(middleName) \(lastName)"
//                } else {
//                    cell.titleLabel?.text = ""
//                }
//            }
            
            cell.titleLabel?.text = self.name
        } else {
            cell.titleLabel?.text = self.items[indexPath.section][indexPath.row]
        }
        
        
//        if row == 0 {
//            cell.titleLabel?.text = "Preferences"
//        } else if row == 1 {
//            cell.titleLabel?.text = "Scroll View and Others"
//        } else if row == 2 {
//            cell.titleLabel?.text = "IB / Code"
//        }
        if indexPath.section == 3 && indexPath.row == 2 {
            cell.titleLabel.textColor = UIColor.white
            cell.titleLabel.backgroundColor = UIColor.red
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            cell.titleLabel.textColor = UIColor.orange
        }
        
        
//        cell.titleLabel?.textColor = isDarkModeEnabled ? .white : .black
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        let with = "\(section)\(row)"

        if with != "00" && with != "01" {
            if with == "10" {
//                self.goToScreen("ContentNavigation")
                let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentNavigation")
                let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
                let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
                UIApplication.shared.keyWindow?.rootViewController = sideMenuController
            } else if with == "40" {
                self.goToScreen("IntroduceController")
            } else if with == "20" {
                self.goToScreen("NotificationController")
            } else if with == "21" {
                self.goToScreen("PromotionNavigation")
            } else if with == "11" {
//                self.goToScreen("TrackBookController")
                guard let navigationController = sideMenuController?.contentViewController as? UINavigationController else {
                    return
                }
                guard let viewController = storyboard?.instantiateViewController(withIdentifier: "TrackBookController") as? NavigationController else {
                    return
                }
                viewController.modalPresentationStyle = .fullScreen
                navigationController.modalPresentationStyle = .fullScreen
                navigationController.present(viewController, animated: true, completion: nil)
            }  else if with == "12" {
                self.goToScreen("ListVoteController")
            } else if with == "13" {
                let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
                
                if userInfo["ID"] != nil {
                    
                    let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteContentNavigation")
                    let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuNavigation")
                    let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
                    UIApplication.shared.keyWindow?.rootViewController = sideMenuController
                } else {
                    var refreshAlert = UIAlertController(title: "Thông báo", message: "Vui lòng đăng nhập/ đăng ký để sử dụng chức năng", preferredStyle: UIAlertController.Style.alert)
                                    
                        refreshAlert.addAction(UIAlertAction(title: "Đăng nhập", style: .default, handler: { (action: UIAlertAction!) in
                            print("Handle Ok logic here")
                            self.performSegue(withIdentifier: "showLogin", sender: nil)
                        }))
                        
                        refreshAlert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (action: UIAlertAction!) in
                            print("Handle Cancel Logic here")
                        }))
                        
                        present(refreshAlert, animated: true, completion: nil)
                }
            } else if with == "30" {
                self.goToScreen("LangContentNavigation")
            }  else if with == "31" {
                self.goToScreen("MoneyContentNavigation")
            }  else if with == "02" {
                self.goToScreen("CustomerController")
//                sideMenuController?.hideMenu()
//                guard let navigationController = sideMenuController?.contentViewController as? UINavigationController else {
//                    return
//                }
//                guard let viewController = storyboard?.instantiateViewController(withIdentifier: "CustomerController") as? CustomerNavigationController else {
//                    return
//                }
//                navigationController.present(ExampleProvider.customIrregularityStyle(delegate: nil), animated: true, completion: nil)
//                self.present(ExampleProvider.customIrregularityStyle(delegate: nil), animated: true, completion: nil)
                
            }else {
//                sideMenuController?.setContentViewController(with: with, animated: true)
                sideMenuController?.hideMenu()
                
                if let identifier = sideMenuController?.currentCacheIdentifier() {
                    print("[Example] View Controller Cache Identifier: \(identifier)")
                }
            }
            
        }
        
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func goToScreen(_ screenName: String) {
//        sideMenuController?.hideMenu()
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        
        if userInfo["ID"] != nil {
            guard let navigationController = sideMenuController?.contentViewController as? UINavigationController else {
                return
            }
            guard let viewController = storyboard?.instantiateViewController(withIdentifier: screenName) as? NavigationController else {
                return
            }
            viewController.modalPresentationStyle = .fullScreen
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: true, completion: nil)
        } else {
            var refreshAlert = UIAlertController(title: "Thông báo", message: "Vui lòng đăng nhập để sử dụng chức năng", preferredStyle: UIAlertController.Style.alert)
                            
                refreshAlert.addAction(UIAlertAction(title: "Đăng nhập", style: .default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                    self.performSegue(withIdentifier: "showLogin", sender: nil)
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(refreshAlert, animated: true, completion: nil)
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
}

class SelectionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
}
