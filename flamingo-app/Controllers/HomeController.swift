//
//  HomeController.swift
//  flamingo-app
//
//  Created by Nguyễn Chí Thành on 8/21/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView
import SideMenuSwift
import GoogleMaps
import GooglePlaces

class HomeController: BaseViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    var backgroundView: UIImageView!
    var offsetBackground = CGFloat(0)
    var startDate: String?
    var endDate: String?
    
    var valStartDate: String?
    var valEndDate: String?
    var PropertyID: String? = nil
    
    var valStartFormatDate: Date?
    var valEndFormatDate: Date?
    
    var listFalshSale = [[String: Any]]()
    var listHistory = [[String: Any]]()
    var listRoom = [[String: Any]]()
    var listNews = [[String: Any]]()
    
    var BookingID: String? = nil
    var textPoint: String?
    
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var blurMenu: VisualEffectView!
    
    var googleMaps: GMSMapView!
    var locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    
    var PropertyRoomID: String?
    
    @IBOutlet var viewParent: UIView!
//    @IBOutlet var popupChosseDate: UIView!
//    @IBOutlet weak var bgPopKoyomi: VisualEffectView!
//    @IBOutlet weak var segementedMonth: UISegmentedControl!
    
//    @IBOutlet weak var bgPopupChosseDate: VisualEffectView!
//    @IBOutlet weak var startDayAndMonth: UILabel!
//    @IBOutlet weak var endDayAndMonth: UILabel!
//    @IBOutlet weak var startDayOfWeek: UILabel!
//    @IBOutlet weak var endDayOfWeek: UILabel!
    
    var choseStartDate = true
    var dataPromotion = [String: Any]()
    var dataNews = [String: Any]()
    
    
    
    @IBAction func onTapMenuAction(_ sender: UIBarButtonItem) {
        self.sideMenuController?.revealMenu()
    }
    
    //MARK: Life Cycle
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyDrtJzFQtIse43GgeTQheWjjUReiM14rjE")
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: 21.33955, longitude: 105.717406, zoom: 15)
        self.googleMaps = GMSMapView.map(withFrame: CGRect(x: 0,y: 20, width: self.view.frame.width, height: 255), camera: camera)
        
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                self.googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("The style definition could not be loaded: \(error)")
        }
        self.googleMaps.isMyLocationEnabled = true
        self.googleMaps.accessibilityElementsHidden = false
        
        self.googleMaps.camera = camera
        
        self.setupUI()
        self.updateUI()
        self.registerCell()
        
        self.locationManager.delegate = self
        self.setViewModal()
//        self.setupKoyomi()
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let year =  components.year
        let month = components.month
        let day = components.day!
        let endDay = components.day! + 1
        
        let nextTwoDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let nextOneDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let componentOne = calendar.dateComponents([.year, .month, .day], from: nextOneDate!)
        let componentTwo = calendar.dateComponents([.year, .month, .day], from: nextTwoDate!)
        
        let weekdayStart = Calendar.current.component(.weekday, from: nextOneDate!)
        let weekdayEnd = Calendar.current.component(.weekday, from: nextTwoDate!)
        
        self.valStartFormatDate = calendar.date(from:componentOne)
        self.valEndFormatDate = calendar.date(from:componentTwo)
        
//        if weekdayStart != 1 {
//            self.startDayOfWeek.text = "Thứ \(weekdayStart)"
//        } else {
//            self.startDayOfWeek.text = "Chủ nhật"
//        }
//
//        if weekdayEnd != 1 {
//            self.endDayOfWeek.text = "Thứ \(weekdayEnd)"
//        } else {
//            self.endDayOfWeek.text = "Chủ nhật"
//        }
        
        
        self.startDate = "\(day)/\(month!)/\(year!)"
        self.endDate = "\(endDay)/\(month!)/\(year!)"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "d/M/y"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let startDateFormat = dateFormatterGet.date(from: self.startDate!) {
            self.startDate = dateFormatterPrint.string(from: startDateFormat)
//            self.startDayAndMonth.text = dateFormatterPrint.string(from: startDateFormat)
        } else {
            print("There was an error decoding the string")
        }
        
        if let endDateFormat = dateFormatterGet.date(from: self.endDate!) {
            self.endDate = dateFormatterPrint.string(from: endDateFormat)
//            self.endDayAndMonth.text = dateFormatterPrint.string(from: endDateFormat)
        } else {
            print("There was an error decoding the string")
        }
        
        
        self.valStartDate = "\(day)-\(month!)-\(year!)"
        self.valEndDate = "\(endDay)-\(month!)-\(year!)"
        
        if let valStartDateFormat = dateFormatterGet.date(from: self.valStartDate!) {
            self.valStartDate = dateFormatterPrint.string(from: valStartDateFormat)
        } else {
            print("There was an error decoding the string")
        }
        
        if let valEndDateFormat = dateFormatterGet.date(from: self.valEndDate!) {
            self.valEndDate = dateFormatterPrint.string(from: valEndDateFormat)
        } else {
            print("There was an error decoding the string")
        }
        

        
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "d/M/yyyy"
//
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
//        if let datetime = dateFormatterGet.date(from: self.startDate!) {
//            print(datetime)
//        }
        
        
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
    
    @IBAction func setting(_ sender: Any) {
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if userInfo["ID"] != nil {
            
            
            let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetupContentNavigation")
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
    }
    
    @IBAction func favorite(_ sender: Any) {
        
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
    }
    
    @IBAction func card(_ sender: Any) {
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if userInfo["ID"] != nil {
            
            self.performSegue(withIdentifier: "showCard", sender: nil)
            
            App.shared.save(value: "false" as AnyObject, forKey: "RELOAD")
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
        
    }
    
    //GET DATA
    
//    @IBAction func chosseDate(_ sender: Any) {
//        self.choseStartDate = true
//        if self.choseStartDate {
//            self.startDayOfWeek.isHidden = false
//            self.startDayAndMonth.isHidden = false
//            self.endDayOfWeek.isHidden = true
//            self.endDayAndMonth.isHidden = true
//        }
//        self.animateIn(popupChosseDate)
//
//    }
//
//
//    @IBAction func choseEndDate(_ sender: Any) {
//        self.choseStartDate = false
//        if !self.choseStartDate {
//            self.startDayOfWeek.isHidden = true
//            self.startDayAndMonth.isHidden = true
//            self.endDayOfWeek.isHidden = false
//            self.endDayAndMonth.isHidden = false
//        }
//        self.animateIn(popupChosseDate)
//    }
//
//    @IBAction func closeChosseDate(_ sender: Any) {
//        self.animateOut(popupChosseDate)
//    }
//
//    @IBAction func selectDate(_ sender: Any) {
////        let calendar = Calendar.current
////        let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: self.valEndFormatDate!)
////        if components.day! <= 0 {
////            self.showMessage(title: "Flamingo", message: "Vui lòng chọn lại ngày nhận và trả")
////        } else {
//            self.animateOut(popupChosseDate)
//            self.tableView.reloadData()
////        }
//
//    }
    
    
    func setupKoyomi(){
        
    }
    
    func setViewModal() {
//        bgPopupChosseDate.colorTintAlpha = 0.7
//        bgPopupChosseDate.blurRadius = 3
//        bgPopupChosseDate.scale = 1
//
//        bgPopKoyomi.colorTintAlpha = 0.7
//        bgPopKoyomi.blurRadius = 4
//        bgPopKoyomi.scale = 1
//
//        segementedMonth.backgroundColor = .clear
//        segementedMonth.tintColor = .clear
//
//        segementedMonth.setTitleTextAttributes([
//            NSAttributedString.Key.foregroundColor: UIColor.lightGray
//            ], for: .normal)
//
//        segementedMonth.setTitleTextAttributes([
//            NSAttributedString.Key.foregroundColor: UIColor.orange
//            ], for: .selected)
//
//        segementedMonth.layer.borderWidth = 0
//
//        segementedMonth.layer.masksToBounds = true
    }
    
    
//    @objc func chosseDate(_ sender: UITapGestureRecognizer) {
//        self.animateIn(popupChosseDate)
//    }
    
    //MARK: Methods
    func registerCell(){
        self.offsetBackground = self.navigationController?.navigationBar.frame.size.height ?? 0 + UIApplication.shared.statusBarFrame.height

    }
    func setupUI(){
        let screenSize = UIScreen.main.bounds.size
        self.backgroundView = UIImageView(frame: CGRect(x: 0, y: -self.offsetBackground, width: screenSize.width, height: screenSize.height - 20))
        self.backgroundView.image = UIImage(named: "bg_home")
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
    
    func animateIn(_ desiredView: UIView) {
        
        let backgroundView = viewParent!
        desiredView.frame = CGRect(x: 0, y: 0, width: viewParent.frame.width, height: viewParent.frame.height)
        backgroundView.addSubview(desiredView)
        
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        }, completion: { _ in
//            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//            statusBar.isHidden = true
        })
        
        
    }
    
    func animateOut(_ desiredView: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.alpha = 0
        }) { _ in
            desiredView.removeFromSuperview()
//            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//            statusBar.isHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func goToDetailDelegate(_ PropertyID: String) {
        
        self.PropertyID = PropertyID
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListSearch" {

            if let viewController: ListSearchViewController = segue.destination as! ListSearchViewController {
                
                viewController.PropertyID =  self.PropertyID!
                viewController.CheckInDate = self.valStartDate
                viewController.CheckOutDate = self.valEndDate
                viewController.valStartDate = self.valStartDate
                viewController.valEndDate = self.valEndDate
                viewController.txtFormHomeStartDate = self.startDate
                viewController.txtFormHomeEndDate = self.endDate
                viewController.valStartFormatDate = self.valStartFormatDate
                viewController.valEndFormatDate = self.valEndFormatDate

            }
            
        } else if segue.identifier == "showDetailRoom" {
            if let vc: RoomDetailViewController = segue.destination as? RoomDetailViewController {
//                var calendar = Calendar.current
//                let valStartFormatDate = calendar.dateComponents([.year, .month, .day], from: self.checkInDate!)
//                let valEndFormatDate = calendar.dateComponents([.year, .month, .day], from: self.checkOutDate!)
                vc.PropertyRoomID = self.PropertyRoomID!
                vc.valStartFormatDate = self.valStartFormatDate
                vc.valEndFormatDate = self.valEndFormatDate
            }
        } else if segue.identifier == "showDetailPromotion" {
            if let vc: DetailPromotionViewController = segue.destination as? DetailPromotionViewController {
                vc.data = self.dataPromotion
            }
        } else if segue.identifier == "showDetailNews" {
           if let viewController: DetailNewsViewController = segue.destination as? DetailNewsViewController {
               viewController.data = self.dataNews
           }
       }
    }
    
    // GET DATA
    func getInfoHome(_ refresh: Bool) {
        self.showProgress()
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "Username": currentUser["LoginName"]
            ] as [String : Any]
        BaseService.shared.homeInfo(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                        if let listBookingHistory = response["Data"]!["ListBookingHistory"] as? [[String: Any]] {
                            self.listHistory = listBookingHistory
                            
                        }
                        
                        if let listBookingHistory = response["Data"]!["ListProperty"] as? [[String: Any]] {
                            self.listRoom = listBookingHistory
                        }
                        
                        if let listPromotion = response["Data"]!["ListPromotion"] as? [[String: Any]] {
                            self.listFalshSale = listPromotion
                        }
                        
                        var reload = Bool(App.shared.getString(key: "RELOAD"))
                        if reload == nil {
                            reload = true
                        }
                        print(reload!)
                        if reload! {
                            self.tableView.reloadData()
                        }
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
    
    func getUserInfo(_ refresh: Bool) {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "ID": currentUser["ID"]
            ] as [String : Any]
        BaseService.shared.getUserInfo(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                    App.shared.save(value: response["Data"] as AnyObject, forKey: "USER_INFO")
//                        print("\(String(describing: response["Data"]!["Point"]! as? String))")
//                        self.textPoint = "\(String(describing: response["Data"]!["Point"]! as? String))"
                        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
                        print(userInfo)
                        let point = userInfo["Point"]!
                        self.textPoint = String(describing: point)
                        if self.textPoint!.elementsEqual("<null>") || self.textPoint!.elementsEqual("") {
                            self.textPoint = "0"
                        }
//                        if Int(self.textPoint!)! < 0 {
//                            self.textPoint = "0"
//                        }
                        var reload = Bool(App.shared.getString(key: "RELOAD"))
                        if reload == nil {
                            reload = true
                        }
                        if reload! {
                            self.tableView.reloadData()
                        }
                        
                })
                    
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupMenu(menuView)
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if userInfo["ID"] != nil {
            self.getUserInfo(true)
        }
        self.getListNews()
        self.getInfoHome(true)
        self.tableView.backgroundColor = .clear
        
        let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 0)
        self.tableView.backgroundColor = color
        
        //                self.backgroundView.backgroundColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        self.backgroundView.image = UIImage(named: "bg_home")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
        
//        self.scrollView.setContentOffset(CGPoint(x: 0, y: 300), animated: true)
//        self.view.layoutIfNeeded()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let scrollPoint = CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height)
//        self.tableView.setContentOffset(scrollPoint, animated: false)
//        self.view.layoutIfNeeded()
//        self.getUserInfo(false)
//        self.getInfoHome(false)
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource, MyDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countRow = 2
        if self.listRoom.count > 0 {
            countRow = countRow + 1
        }
        if self.listHistory.count > 0 {
            countRow = countRow + 1
        }
        if self.listFalshSale.count > 0 {
            countRow = countRow + 1
        }
        if self.listNews.count > 0 {
            countRow = countRow + 1
        }
        
        return countRow
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHomeViewCell") as! SearchHomeViewCell
            cell.btnFormSearch.tag = indexPath.row
            cell.btnFormSearch.addTarget(self, action: #selector(search(_:)), for: .touchUpInside)
            
//            cell.viewListReceipt.addTarget(self, action: #selector(viewListReceipt(_:)), for: .touchUpInside)
//            cell.viewShowReciptDetail.addTarget(self, action: #selector(viewShowReciptDetail(_:)), for: .touchUpInside)
            
            let tapGestureRecognizerDetail = UITapGestureRecognizer(target: self, action: #selector(viewListReceipt(_:)))
            cell.viewListReceipt.isUserInteractionEnabled = true
            cell.viewListReceipt.addGestureRecognizer(tapGestureRecognizerDetail)
            
            
            let tapGestureRecognizerList = UITapGestureRecognizer(target: self, action: #selector(viewShowReciptDetail(_:)))
            cell.viewShowReciptDetail.isUserInteractionEnabled = true
            cell.viewShowReciptDetail.addGestureRecognizer(tapGestureRecognizerList)
            cell.txtStartDate.text = self.startDate
            cell.txtEnDate.text = self.endDate
            
//            let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
//            print(userInfo)
            if self.textPoint != nil {
                cell.point.text = Int(self.textPoint!)?.formattedWithSeparator
            }
            
            let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
            
            if userInfo["ID"] != nil {
                cell.btnLogin.isHidden = true
            }
            
            return cell
        }
        else if row == 1 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "FlashSalesTableViewCell", for: indexPath) as! FlashSalesTableViewCell
            cell.data = self.listFalshSale
            cell.callback = { recived in
                self.dataPromotion = recived
                self.performSegue(withIdentifier: "showDetailPromotion", sender: nil)
                
                App.shared.save(value: "false" as AnyObject, forKey: "RELOAD")
            }
            cell.collectionView.reloadData()

            return cell
        } else if row == 2 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            cell.data = self.listNews
            cell.callback = { recived in
                self.dataNews = recived
                self.performSegue(withIdentifier: "showDetailNews", sender: nil)
                
                App.shared.save(value: "false" as AnyObject, forKey: "RELOAD")
            }
            cell.collectionView.reloadData()

            return cell
        }
        else if row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastBookViewCell", for: indexPath) as! LastBookViewCell
            cell.data = self.listHistory
            
            cell.callback = { recived in
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let controller = storyboard.instantiateViewController(withIdentifier: "DetailTrackViewController") as! DetailTrackViewController
//                controller.BookingID = recived
//                controller.listBook = self.listHistory[indexPath.row]
//                self.navigationController?.pushViewController(controller, animated: true)
                
                self.PropertyRoomID = recived
                self.performSegue(withIdentifier: "showDetailRoom", sender: nil)
                
                App.shared.save(value: "false" as AnyObject, forKey: "RELOAD")
            }
            
            
            cell.collectionView.reloadData()
            return cell
        } else if row == 4 && self.listRoom.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell", for: indexPath) as! RecommendTableViewCell
            cell.data = self.listRoom
            cell.delegate = self
            
            cell.collectionView.reloadData()

            cell.callback = { recived in
                self.PropertyID = recived
                self.performSegue(withIdentifier: "ListSearch", sender: nil)
                
                App.shared.save(value: "false" as AnyObject, forKey: "RELOAD")
            }
            cell.collectionView.reloadData()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GGMapTableViewCell", for: indexPath) as! GGMapTableViewCell
//            cell.showCurrentLocationOnMap()
            
            
            //        latitude: 21.33955, longitude: 105.717406
//            let camera = GMSCameraPosition.camera(withLatitude: 21.33955, longitude: 105.717406, zoom: 15)
//            self.googleMaps = GMSMapView.map(withFrame: CGRect(x: 0,y: 20, width: cell.viewMap.frame.size.width, height: cell.viewMap.frame.size.height - 20), camera: camera)
//
//            do {
//                if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
//                    self.googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//                } else {
//                    NSLog("Unable to find style.json")
//                }
//            } catch {
//                NSLog("The style definition could not be loaded: \(error)")
//            }
//            self.googleMaps.isMyLocationEnabled = true
//            self.googleMaps.accessibilityElementsHidden = false
//            self.tableViewHeight.constant = self.tableView.contentSize.height

            cell.viewMap.addSubview(self.googleMaps)
            self.view.layoutIfNeeded()
//            self.tableView.reloadData()
            return cell
        }
        
    }
    
    
    
    @objc func viewShowReciptDetail(_ sender: UITapGestureRecognizer) {
        
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if userInfo["ID"] != nil {
            
            self.performSegue(withIdentifier: "showDetailUser", sender: nil)

            App.shared.save(value: "false" as AnyObject, forKey: "RELOAD")
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
        
    }
    
    @objc func viewListReceipt(_ sender: UITapGestureRecognizer) {
        
        
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if userInfo["ID"] != nil {
            
            self.performSegue(withIdentifier: "showListReciept", sender: nil)
            
            App.shared.save(value: "false" as AnyObject, forKey: "RELOAD")
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
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            self.tableViewHeight.constant = self.tableView.contentSize.height + 285
            self.view.layoutIfNeeded()
            return 150
        } else if indexPath.row == 1{
            self.tableViewHeight.constant = self.tableView.contentSize.height + 220
            self.view.layoutIfNeeded()
            return 220
        } else if indexPath.row == 2{
            self.tableViewHeight.constant = self.tableView.contentSize.height + 220
            self.view.layoutIfNeeded()
            return 220
        } else if indexPath.row == 3{
            self.tableViewHeight.constant = self.tableView.contentSize.height + 220
            self.view.layoutIfNeeded()
            return 220
        } else if indexPath.row == 4{
            self.tableViewHeight.constant = self.tableView.contentSize.height + 255
            self.view.layoutIfNeeded()
            return 255
        } else {
            self.tableViewHeight.constant = self.tableView.contentSize.height + 311
            self.view.layoutIfNeeded()
            return 311
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = self.scrollView.contentOffset.y + self.offsetBackground
        var offset = y / self.offsetBackground
        self.view.layoutIfNeeded()
        if y - 190 > self.offsetBackground {
            
            //Set logo
            let logo = UIImage(named: "logo_home_orange")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            
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
            let logo = UIImage(named: "logo_home_white")
            let imageView = UIImageView(image:logo)
            self.navigationItem.titleView = imageView
            
            
            UIView.animate(withDuration: 0.2, animations: {
                let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: offset - 4)
                self.tableView.backgroundColor = color

//                self.backgroundView.backgroundColor = color
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.backgroundColor = color
//                UIApplication.shared.statusBarView?.backgroundColor = color
                self.backgroundView.image = UIImage(named: "bg_home")
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.barStyle = .black
            })
        }
    }
    
    
    // Action buttonSearch
    
    @objc func search(_ sender: UIButton) {
        
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let index = IndexPath(row: 0, section: 0)
        let cell: SearchHomeViewCell = self.tableView.cellForRow(at: index) as! SearchHomeViewCell
        let content = cell.txtSearch.text!
        
//        viewController.Content = content
//        viewController.CheckInDate = self.valStartDate
//        viewController.CheckOutDate = self.valEndDate
//        viewController.txtFormHomeStartDate = self.startDate
//        viewController.txtFormHomeEndDate = self.endDate
        let params = [
            "Username": "",
            "Content" : content,
            "CheckInDate": self.valStartDate,
            "CheckOutDate": self.valEndDate
        ]
        BaseService.shared.searchRoom(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                if let _ = response["Data"]! as? [[String:Any]] {
                    DispatchQueue.main.async(execute: {
                        if let jsonData = response["Data"] as? [[String:AnyObject]] {
                            
                            self.listRoom = jsonData
                        }
//                        let totalRow = self.tableView.numberOfRows(inSection: 0)
//                        let indexPath = NSIndexPath(row: totalRow - 1, section: 0)
//                        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .middle, animated: true)
                        
                        self.tableView.reloadData()
                        
//                        let cellRect = self.tableView.rectForRow(at: indexPath as IndexPath)
//                        print(cellRect)
//                        let indexPath = NSIndexPath(item: 3, section: 0)
//                        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
//                        self.scrollView.setContentOffset(CGPoint(x: 0, y: self.tableView.frame.origin.y + 300), animated: true)
//                        self.view.layoutIfNeeded()
//                        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 300)
                    })
                    
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    
    
}



