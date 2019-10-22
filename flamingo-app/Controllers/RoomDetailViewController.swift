//
//  RoomDetailViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/24/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView

class RoomDetailViewController: BaseViewController {

    var Data = [["Name":"How To Use Firebase Crashlytics In Swift 4 Xcode 9","Date":"5 Days.","TutorialImageName":"Crashlytics"],
                ["Name":"How To Use Google Snackbar In Swift 4 Xcode 9 ","Date":"2 Days.","TutorialImageName":"Snackbar"]]
    
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var bgEffect: VisualEffectView!
    @IBOutlet weak var bgNumberRoom: VisualEffectView!
    @IBOutlet weak var bgEffectCountPeople: VisualEffectView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewParent: UIView!
    @IBOutlet weak var imageHeader: UIImageView!
    
    @IBOutlet weak var countRate: UILabel!
    @IBOutlet weak var tapViewLike: UIView!
    @IBOutlet weak var icon_like: UIImageView!
    @IBOutlet weak var blurLike: VisualEffectView!
    @IBOutlet weak var blurRate: VisualEffectView!
    
    // Capacity
    @IBOutlet weak var incrementCapacity: UIButton!
    @IBOutlet weak var decrementCapacity: UIButton!
    @IBOutlet weak var txtCapacity: UILabel!
    
    
    @IBOutlet weak var incrementAdult: UIButton!
    @IBOutlet weak var decrementAdult: UIButton!
    @IBOutlet weak var txtAdult: UILabel!
    @IBOutlet var popupChosseDate: UIView!
    
    @IBOutlet weak var titleChosseDate: UILabel!
    
    @IBOutlet weak var incrementChild: UIButton!
    @IBOutlet weak var decrementChild: UIButton!
    @IBOutlet weak var txtChild: UILabel!
//    @IBOutlet weak var segementedChosseDate: UISegmentedControl!
    
    var valStartFormatDate: Date?
    var valEndFormatDate: Date?
    var choseStartDate = true
    
    var listPictures = [[String: Any]]()
    var ListUtilities = [[String: Any]]()
    var ListVotes = [[String: Any]]()
    
    var showListPicture = [[String: Any]]()
    
    var countCapacity = 1
    var countAdult = 2
    var countChild = 2
    
    
    var PropertyRoomID: String?
    var infoDetailRoom: [String: Any]? = nil
    
    var Headerview : UIView!
    var NewHeaderLayer : CAShapeLayer!
    
    private let Headerheight : CGFloat = 420
    private let Headercut : CGFloat = 0
    
    
    var startDateStr: String?
    var endDateStr: String?
    
    var valStartDate: String?
    var valEndDate: String?
    
    @IBOutlet weak var startDayAndMonth: UILabel!
    @IBOutlet weak var endDayAndMonth: UILabel!
    @IBOutlet weak var startDayAndMonthPopup: UILabel!
    @IBOutlet weak var endDayAndMonthPopup: UILabel!
    @IBOutlet weak var startDayOfWeek: UILabel!
    @IBOutlet weak var endDayOfWeek: UILabel!
    
    
    @IBOutlet weak var calendarView: CalendarView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UpdateView()
        self.setViewModal()
        self.setupKoyomi()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        CalendarView.Style.cellShape                = .bevel(17)
        CalendarView.Style.cellColorDefault         = UIColor.clear
        CalendarView.Style.cellColorToday           = UIColor(red:242.00, green:94.00, blue:28.00, alpha:1.00)
        CalendarView.Style.cellSelectedBorderColor  = UIColor(red:242.00/255.00, green:94.00/255.00, blue:28.00/255.00, alpha:1.00)
        CalendarView.Style.cellEventColor           = UIColor(red:242.00, green:94.00, blue:28.00, alpha:1.00)
        CalendarView.Style.headerTextColor          = UIColor.black
        CalendarView.Style.cellTextColorDefault     = UIColor.black
        CalendarView.Style.cellTextColorToday       = UIColor.orange
        CalendarView.Style.headerBackgroundColor    = UIColor.clear
        
        //        CalendarView.Style.cellBorderWidth = 5
        CalendarView.Style.cellSelectedTextColor = UIColor(red:250.00, green:250.00, blue:250.00, alpha:1.00)
        CalendarView.Style.cellSelectedColor = UIColor(red:242.00/255.00, green:94.00/255.00, blue:28.00/255.00, alpha:1.00)
        
        CalendarView.Style.firstWeekday             = .monday
        
        CalendarView.Style.locale                   = Locale(identifier: "vi_VN")
        
        CalendarView.Style.timeZone                 = TimeZone(abbreviation: "UTC")!
        
        CalendarView.Style.cellFont = UIFont(name: "Helvetica", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
        CalendarView.Style.headerFont = UIFont(name: "Helvetica", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
        CalendarView.Style.subHeaderFont = UIFont(name: "Helvetica", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
        
        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.direction = .horizontal
        calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = false
        
        self.txtCapacity.text = String(self.countCapacity)
        self.txtAdult.text = String(self.countAdult)
        self.txtChild.text = String(self.countChild)
//        self.decrementCapacity.isEnabled = false
//        self.decrementAdult.isEnabled = false
//        self.decrementChild.isEnabled = false
        
        
        self.blurLike.colorTintAlpha = 0.2
        self.blurLike.blurRadius = 13
        self.blurLike.layer.cornerRadius = 18
        self.blurLike.scale = 1
        self.blurLike.clipsToBounds = true
        
        
        self.blurRate.colorTintAlpha = 0.2
        self.blurRate.blurRadius = 1
        self.blurRate.layer.cornerRadius = 12
        self.blurRate.scale = 1
        self.blurRate.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewImageScreen(_:)))
        self.imageHeader.addGestureRecognizer(tapGesture)
        self.imageHeader.isUserInteractionEnabled = true
        
        
        let calendar = Calendar.current
        let start = calendar.dateComponents([.year, .month, .day], from: self.valStartFormatDate!)
        let end = calendar.dateComponents([.year, .month, .day], from: self.valEndFormatDate!)
        
        let startYear =  start.year
        let startMonth = start.month
        let startDay = start.day
        
        let endYear =  end.year
        let endMonth = end.month
        let endDay = end.day
        
        
        let weekdayStart = Calendar.current.component(.weekday, from: self.valStartFormatDate!)
        let weekdayEnd = Calendar.current.component(.weekday, from: self.valEndFormatDate!)
        
        
        if weekdayStart != 1 {
            self.startDayOfWeek.text = "Thứ \(weekdayStart)"
        } else {
            self.startDayOfWeek.text = "Chủ nhật"
        }
        
        if weekdayEnd != 1 {
            self.endDayOfWeek.text = "Thứ \(weekdayEnd)"
        } else {
            self.endDayOfWeek.text = "Chủ nhật"
        }
        
        
        self.startDateStr = "\(startDay!)/\(startMonth!)/\(startYear!)"
        self.endDateStr = "\(endDay!)/\(endMonth!)/\(endYear!)"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "d/M/y"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let startDateFormat = dateFormatterGet.date(from: self.startDateStr!) {
            self.startDateStr = dateFormatterPrint.string(from: startDateFormat)
            self.startDayAndMonth.text = dateFormatterPrint.string(from: startDateFormat)
            self.startDayAndMonthPopup.text = dateFormatterPrint.string(from: startDateFormat)
        } else {
            print("There was an error decoding the string")
        }
        
        if let endDateFormat = dateFormatterGet.date(from: self.endDateStr!) {
            self.endDateStr = dateFormatterPrint.string(from: endDateFormat)
            self.endDayAndMonth.text = dateFormatterPrint.string(from: endDateFormat)
            self.endDayAndMonthPopup.text = dateFormatterPrint.string(from: endDateFormat)
        } else {
            print("There was an error decoding the string")
        }
        
        
        self.valStartDate = "\(startYear!)-\(startMonth!)-\(startDay!)"
        self.valEndDate = "\(endYear!)-\(endMonth!)-\(endDay!)"
        
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
    }
    
//    @IBAction func segementChangeValue(_ sender: Any) {
//        print(segementedChosseDate.selectedSegmentIndex)
//        let month: MonthType = {
//            switch segementedChosseDate.selectedSegmentIndex {
//            case 0:  return .previous
//            case 1:  return .current
//            default: return .next
//            }
//        }()
//        print(month)
//        koyomi.display(in: month)
//    }
    
    
    @IBAction func chosseDate(_ sender: Any) {
        self.choseStartDate = true
        if self.choseStartDate {
            self.titleChosseDate.text = "CHỌN NGÀY NHẬN PHÒNG"
            self.startDayOfWeek.isHidden = false
            self.startDayAndMonthPopup.isHidden = false
            self.endDayOfWeek.isHidden = true
            self.endDayAndMonthPopup.isHidden = true
        }
        self.animateIn(popupChosseDate)
    }
    @IBAction func chosseEndDate(_ sender: Any) {
        self.choseStartDate = false
        if !self.choseStartDate {
            self.titleChosseDate.text = "CHỌN NGÀY TRẢ PHÒNG"
            self.startDayOfWeek.isHidden = true
            self.startDayAndMonthPopup.isHidden = true
            self.endDayOfWeek.isHidden = false
            self.endDayAndMonthPopup.isHidden = false
        }
        self.animateIn(popupChosseDate)
    }
    
    @IBAction func closeChosseDate(_ sender: Any) {
        self.animateOut(popupChosseDate)
    }
    
    @IBAction func selectDate(_ sender: Any) {
        self.animateOut(popupChosseDate)
        
    }
    
    @objc func viewImageScreen(_ sender: UITapGestureRecognizer) {
        self.showListPicture = self.listPictures
        self.performSegue(withIdentifier: "showImage", sender: nil)
    }
    
    // GET DATA
    @IBAction func viewImage(_ sender: Any) {
        self.showListPicture = self.listPictures
        self.performSegue(withIdentifier: "showImage", sender: nil)
    }
    
    func getDetailRoom() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        var username = ""
        if currentUser["LoginName"] != nil {
            username = currentUser["LoginName"] as! String
        }
        
        let params = [
            "Username": username,
            "PropertyRoomID": self.PropertyRoomID!,
            "CheckInDate": self.valStartDate!,
            "CheckOutDate": self.valEndDate!
            ] as [String : Any]
        self.showProgress()
        BaseService.shared.detailRoom(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"] {
                    DispatchQueue.main.async(execute: {
                        
                        if let infoDetail = response["Data"] as? [String: Any] {
                            self.infoDetailRoom = infoDetail
                        }
                        if let listPicture = response["Data"]!["ListPictures"] as? [[String: Any]] {
                            self.listPictures = listPicture
                            
                        }
                        
                        if let listUtilities = response["Data"]!["ListUtilities"] as? [[String: Any]] {
                            self.ListUtilities = listUtilities
                        }
                        if let listVotes = response["Data"]!["ListVote"] as? [[String: Any]] {
                            self.ListVotes = listVotes
                        }
                        
//                        self.countRate.text = "\(String(describing: self.infoDetailRoom!["AverageVote"]!))/ \(String(describing: self.infoDetailRoom!["CountVote"]!)) đánh giá"
                        self.countRate.text = "8.0/ \(String(describing: self.infoDetailRoom!["CountVote"]!)) đánh giá"
                        if self.infoDetailRoom!["IsFavourite"] as! Int == 0 {
                            self.icon_like.image = UIImage(named: "heart_white")
                        } else {
                            self.icon_like.image = UIImage(named: "heart_like")
                        }
                        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addFavorite(_:)))
                        self.tapViewLike.isUserInteractionEnabled = true
                        self.tapViewLike.addGestureRecognizer(tap)
                        
                        self.imageHeader.downloaded(from: (self.listPictures[0]["Picture"] as? String)!)
                        self.imageHeader.contentMode = .scaleAspectFill
                        
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
    
    
    func setupKoyomi(){
        
        
        
//        koyomi.circularViewDiameter = 0.5
//        koyomi.calendarDelegate = self as KoyomiDelegate
//        koyomi.inset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
//        koyomi.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
//        koyomi.dayBackgrondColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0)
//        koyomi.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
//        koyomi.dayPosition = .center
//        //        koyomi.selectionMode = .sequence(style: .semicircleEdge)
//        koyomi.selectedStyleColor = UIColor(red: 242/255, green: 94/255, blue: 28/255, alpha: 1)
//        koyomi
//            .setDayFont(size: 14)
//            .setWeekFont(size: 0)
//
//        segementedChosseDate.backgroundColor = .clear
//        segementedChosseDate.tintColor = .clear
//
//        segementedChosseDate.setTitleTextAttributes([
//            NSAttributedString.Key.foregroundColor: UIColor.lightGray
//            ], for: .normal)
//
//        segementedChosseDate.setTitleTextAttributes([
//            NSAttributedString.Key.foregroundColor: UIColor.orange
//            ], for: .selected)
//
//        segementedChosseDate.layer.borderWidth = 0
//
//        segementedChosseDate.layer.masksToBounds = true
    }
    
    
    
    @objc func addFavorite(_ sender: UITapGestureRecognizer) {
//        self.getDetailRoom()
        
        let userInfo = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        if userInfo["ID"] != nil {
            
            if self.infoDetailRoom!["IsFavourite"] as! Int == 0 {
                let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
                var username = ""
                if currentUser["LoginName"] != nil {
                    username = currentUser["LoginName"] as! String
                }
                let params = [
                    "UserName": username,
                    "PropertyRoomID": self.PropertyRoomID,
                    "IsAdd": "True"
                    ] as [String : Any]
                self.showProgress()
                BaseService.shared.addFavorite(params: params as [String : AnyObject]) { (status, response) in
                    self.hideProgress()
                    if status {
                        if let _ = response["Data"] {
                            
                            DispatchQueue.main.async(execute: {
                                if (response["Data"]!["Result"] as! Int == 1) {
                                    self.icon_like.image = UIImage(named: "heart_like")
                                    self.getDetailRoom()
                                }
                            })
                            
                            
                        } else {
                            self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                        }
                    } else {
                        self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                    }
                }
                
            } else {
                
                let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
                var username = ""
                if currentUser["LoginName"] != nil {
                    username = currentUser["LoginName"] as! String
                }
                let params = [
                    "UserName": username,
                    "PropertyRoomID": self.PropertyRoomID,
                    "IsAdd": "False"
                    ] as [String : Any]
                self.showProgress()
                BaseService.shared.addFavorite(params: params as [String : AnyObject]) { (status, response) in
                    self.hideProgress()
                    if status {
                        print(response)
                        if let _ = response["Data"] {
                            
                            DispatchQueue.main.async(execute: {
                                if (response["Data"]!["Result"] as! Int == 1) {
                                    self.icon_like.image = UIImage(named: "heart_white")
                                    self.getDetailRoom()
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
    
    func setViewModal() {
        popupView.bounds = CGRect(x: 0, y: 0, width: viewParent.bounds.width, height: viewParent.bounds.height)
        // Set Background
        bgEffect.colorTintAlpha = 0.7
        bgEffect.blurRadius = 3
        bgEffect.scale = 1
        //        visualEffectFormSearch.clipsToBounds = true
        //
        //        visualEffectFormSearch.layer.cornerRadius = 25
        
        bgNumberRoom.colorTintAlpha = 0.7
        bgNumberRoom.blurRadius = 4
        bgNumberRoom.scale = 1
        bgNumberRoom.clipsToBounds = true
        bgNumberRoom.layer.cornerRadius = 15
        
        
        bgEffectCountPeople.colorTintAlpha = 0.7
        bgEffectCountPeople.blurRadius = 4
        bgEffectCountPeople.scale = 1
        bgEffectCountPeople.clipsToBounds = true
        bgEffectCountPeople.layer.cornerRadius = 15
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeModal(_ sender: Any) {
        animateOut(popupView)
    }
    
    
    
    func UpdateView() {
//        tableView.backgroundColor = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
        Headerview = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(Headerview)
        
        NewHeaderLayer = CAShapeLayer()
        NewHeaderLayer.fillColor = UIColor.black.cgColor
        Headerview.layer.mask = NewHeaderLayer
        
        let newheight = Headerheight - Headercut / 2
        tableView.contentInset = UIEdgeInsets(top: newheight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newheight)
        
        self.Setupnewview()
    }
    func Setupnewview() {
        let newheight = Headerheight - Headercut / 2
        var getheaderframe = CGRect(x: 0, y: -newheight, width: self.viewParent.bounds.width, height: Headerheight)
        
        if tableView.contentOffset.y < newheight
        {
            getheaderframe.origin.y = tableView.contentOffset.y
            getheaderframe.size.height = -tableView.contentOffset.y + Headercut / 2
        }
        
        Headerview.frame = getheaderframe
        let cutdirection = UIBezierPath()
        cutdirection.move(to: CGPoint(x: 0, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: getheaderframe.height))
        cutdirection.addLine(to: CGPoint(x: 0, y: getheaderframe.height - Headercut))
        
        NewHeaderLayer.path = cutdirection.cgPath
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.Setupnewview()
        
        var offset = scrollView.contentOffset.y / 200
        if offset > -0.5
        {
            UIView.animate(withDuration: 0.2, animations: {
                offset = 1
                let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: offset)
                self.navigationController?.navigationBar.tintColor = UIColor.gray
                self.navigationController?.navigationBar.backgroundColor = color
//                UIApplication.shared.statusBarView?.backgroundColor = color
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
                self.navigationController?.navigationBar.barStyle = .default
            })
        }
        else
        {
            UIView.animate(withDuration: 0.2, animations: {
                let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: offset)
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.backgroundColor = color
//                UIApplication.shared.statusBarView?.backgroundColor = color
                
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.barStyle = .black
            })
        }
    }
    
    @objc func book(_ sender: Any) {
        animateIn(popupView)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailPayment" {
            animateOut(popupView)
            
            let viewController: DetailPaymentViewController = segue.destination as! DetailPaymentViewController
            print(self.valStartFormatDate!)
            print(self.valEndFormatDate!)
            viewController.PropertyRoomID = self.PropertyRoomID!
            viewController.countCapacity = self.countCapacity
            viewController.countAdult = self.countAdult
            viewController.countChild = self.countChild
            viewController.valStartFormatDate = self.valStartFormatDate!
            viewController.valEndFormatDate = self.valEndFormatDate!
            
        } else if segue.identifier == "DetailVoteViewController" {
            let viewController: DetailVoteViewController = segue.destination as! DetailVoteViewController
            viewController.listVote = self.ListVotes
        } else if segue.identifier == "showImage" {
            let viewController: ImageFullScreenViewController = segue.destination as! ImageFullScreenViewController
            viewController.imageArr = self.showListPicture
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 0)
        self.tableView.backgroundColor = color
        
        let today = Date()
        self.calendarView.setDisplayDate(today, animated: false)
        //                self.backgroundView.backgroundColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.valEndFormatDate == nil || self.valStartFormatDate == nil {
            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            let year =  components.year
            let month = components.month
            let day = components.day
            
            
            self.valStartFormatDate = calendar.date(from:components)
            self.valEndFormatDate = calendar.date(from:components)
        }
        
        
        self.getDetailRoom()
        self.tableView.backgroundColor = .clear
        
        let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 0)
        self.tableView.backgroundColor = color
        
        //                self.backgroundView.backgroundColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let offset = 1
        let color = UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: CGFloat(offset))
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = color
//        UIApplication.shared.statusBarView?.backgroundColor = color

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    // incrementCapacity
    
    @IBAction func incrementCapacity(_ sender: Any) {
//        if (self.infoDetailRoom?["Allotment"] as? Int)! > countCapacity {
//            countCapacity = (countCapacity + 1)
//             self.txtCapacity.text = String(countCapacity)
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = false
//        }
        countCapacity = (countCapacity + 1)
         self.txtCapacity.text = String(countCapacity)
        if countCapacity > 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = false
        }
        
//        if (self.infoDetailRoom?["Allotment"] as? Int)! == countCapacity {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = false
//        }
        
        
    }
    
    @IBAction func decrementCapacity(_ sender: Any) {
        if 0 < countCapacity {
            countCapacity = (countCapacity - 1)
            self.txtCapacity.text = String(countCapacity)
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = false
        }
//        if (self.infoDetailRoom?["Allotment"] as? Int)! > countCapacity {
//
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = false
//        }
        
        if countCapacity == 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = false
        }
        
    }
    
    @IBAction func incrementAdult(_ sender: Any) {
//        if (self.infoDetailRoom?["MaxAdult"] as? Int)! > countAdult {
//            countAdult = (countAdult + 1)
//            self.txtAdult.text = String(countAdult)
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementAdult.setImage(yourImage, for: .normal)
//            incrementAdult.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementAdult.setImage(yourImage, for: .normal)
//            incrementAdult.isEnabled = false
//        }
        
                    countAdult = (countAdult + 1)
                    self.txtAdult.text = String(countAdult)
        if countAdult > 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = false
        }
        
//        if (self.infoDetailRoom?["MaxAdult"] as? Int)! == countAdult {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementAdult.setImage(yourImage, for: .normal)
//            incrementAdult.isEnabled = false
//        }
    }
    
    @IBAction func decrementAdult(_ sender: Any) {
        if 0 < countAdult {
            countAdult = (countAdult - 1)
            self.txtAdult.text = String(countAdult)
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = false
        }
//        if (self.infoDetailRoom?["MaxAdult"] as? Int)! > countAdult {
//
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementAdult.setImage(yourImage, for: .normal)
//            incrementAdult.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = false
//        }
        
        if countAdult == 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = false
        }
    }
    
    @IBAction func decrementChild(_ sender: Any) {
        if 0 < countChild {
            countChild = (countChild - 1)
            self.txtChild.text = String(countChild)
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = false
        }
//        if (self.infoDetailRoom?["MaxChild"] as? Int)! > countChild {
//
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementChild.setImage(yourImage, for: .normal)
//            incrementChild.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementChild.setImage(yourImage, for: .normal)
//            incrementChild.isEnabled = false
//        }
        
        if countChild == 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = false
        }
    }
    
    @IBAction func incrementChild(_ sender: Any) {
//        if (self.infoDetailRoom?["MaxChild"] as? Int)! > countChild {
//            countChild = (countChild + 1)
//            self.txtChild.text = String(countChild)
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementChild.setImage(yourImage, for: .normal)
//            incrementChild.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementChild.setImage(yourImage, for: .normal)
//            incrementChild.isEnabled = false
//        }
        countChild = (countChild + 1)
        self.txtChild.text = String(countChild)
        if countChild > 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = false
        }
        
//        if (self.infoDetailRoom?["MaxChild"] as? Int)! == countChild {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementChild.setImage(yourImage, for: .normal)
//            incrementChild.isEnabled = false
//        }
    }
    
    
    
    
}


extension RoomDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Tableview Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
        
        if self.infoDetailRoom != nil {
            cell.nameItem.text = self.infoDetailRoom!["Name"] as? String
//            cell.priceItem.text = "\(String(describing: self.infoDetailRoom!["Price"]!))"
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = Locale(identifier: "vi_VN")
            cell.priceItem.text = numberFormatter.string(from: NSNumber(value: self.infoDetailRoom!["Price"] as! Double))!
            cell.sizeItem.text =  "\(self.infoDetailRoom!["Size"] as! String) (bao gồm khuôn viên Villa)"
            cell.noteItem.text = "\(self.infoDetailRoom!["Condition"]!)\n \(self.infoDetailRoom!["Notes"]!)"
            cell.desc.text = self.infoDetailRoom!["Description"] as? String
            cell.reviewItem.rating = self.infoDetailRoom!["StarNum"] as! Double
//            let countVote = "\(String(describing: self.infoDetailRoom!["AverageVote"]!))"
//            let countVoteStr = self.infoDetailRoom!["AverageVote"]
//            print(convertCountVote)
//
//            if let countVoteStr = self.infoDetailRoom!["AverageVote"] {
//                print(Int("\(countVoteStr)")!)
//            }
//
            
//            cell.countVote.text = "\(String(describing: self.infoDetailRoom!["AverageVote"]!))"

            cell.countVote.text = "8.0"
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: self.valEndFormatDate!)
            
            cell.countDay.text = "/\(components.day!) đêm"
            
            cell.dataListPictures = self.listPictures
            cell.dataListUtilities = self.ListUtilities
            
            if self.ListVotes.count > 0 {
                cell.noteRate.text = "\(String(describing: self.ListVotes[0]["Notes"]!))"
                cell.start.text = "\(String(describing: self.ListVotes[0]["Star"]!))"
                
                print( "\(String(describing: self.ListVotes[0]["Name"]!))")
                
                cell.nameRate.text = "\(String(describing: self.ListVotes[0]["Name"]!))"
                cell.moreRate.addTarget(self, action: #selector(moreRate(_:)), for: .touchDown)
            }
            
            cell.collectionViewPicture.reloadData()
            cell.collectionViewUltilities.reloadData()
            
            cell.showImage = {
                self.showListPicture = self.listPictures
                self.performSegue(withIdentifier: "showImage", sender: nil)
            }

        }
        
        
        cell.btnBook.tag = indexPath.row
        cell.btnBook.addTarget(self, action: #selector(book(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func moreRate(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "DetailVoteViewController", sender: nil)
    }
    
}


//extension RoomDetailViewController: KoyomiDelegate {
//    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
//        //        print(indexPath)
//        //        print(date as Any)
//    }
//
//    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
//        let calendar = Calendar.current
//        //        if date != nil {
//        //            let start = calendar.dateComponents([.year, .month, .day], from: date!)
//        //            let startyear =  start.year
//        //            let startmonth = start.month
//        //            let startday = start.day
//        //            let weekday = Calendar.current.component(.weekday, from: date!)
//        //            self.startDayAndMonthPopup.text = "\(startday!) Tháng \(startmonth!)"
//        //            self.startDayAndMonth.text = "\(startday!)/\(startmonth!)/\(startyear!)"
//        //            self.valStartDate = "\(startyear!)-\(startmonth!)-\(startday!)"
//        ////            self.startDate = "\(startday!) Tháng \(startmonth!)"
//        ////
//        ////            self.valStartDate = "\(startday!)-\(startmonth!)-\(startyear!)"
//        //            self.valStartFormatDate = date
//        //            if weekday != 1 {
//        //                self.startDayOfWeek.text = "Thứ \(weekday)"
//        //            } else {
//        //                self.startDayOfWeek.text = "Chủ nhật"
//        //            }
//        //
//        //        }
//        //
//        //        if toDate != nil {
//        //            let end = calendar.dateComponents([.year, .month, .day], from: toDate!)
//        //
//        //            let weekday = Calendar.current.component(.weekday, from: toDate!)
//        //            let endyear =  end.year
//        //            let endmonth = end.month
//        //            let endday = end.day
//        //
//        //            self.valEndFormatDate = toDate
//        //            self.endDayAndMonth.text = "\(endday!)/\(endmonth!)/\(endyear!)"
//        //            self.endDayAndMonthPopup.text = "\(endday!) Tháng \(endmonth!)"
//        ////            self.valEndDate = "\(endday!)-\(endmonth!)-\(endyear!)"
//        ////            self.endDate = "\(endday!) Tháng \(endmonth!)"
//        //
//        //            self.valEndDate = "\(endyear!)-\(endmonth!)-\(endday!)"
//        //            if weekday != 1 {
//        //                self.endDayOfWeek.text = "Thứ \(weekday)"
//        //            } else {
//        //                self.endDayOfWeek.text = "Chủ nhật"
//        //            }
//        //        }
//
////        let dateFormatterGet = DateFormatter()
////        dateFormatterGet.dateFormat = "d/M/y"
////
////        let dateFormatterPrint = DateFormatter()
////        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
////        if date != nil {
////            if choseStartDate {
////                let start = calendar.dateComponents([.year, .month, .day], from: date!)
////                let year =  start.year
////                let month = start.month
////                let day = start.day
////                let weekday = Calendar.current.component(.weekday, from: date!)
////                self.valStartFormatDate = calendar.date(from:start)
////                //                self.startDayAndMonth.text = "\(startday!) Tháng \(startmonth!)"
////                //                self.startDate = "\(startday!) Tháng \(startmonth!)"
////
////                //                self.valStartDate = "\(startday!)-\(startmonth!)-\(startyear!)"
////                if weekday != 1 {
////                    self.startDayOfWeek.text = "Thứ \(weekday)"
////                } else {
////                    self.startDayOfWeek.text = "Chủ nhật"
////                }
////
////                self.startDate = "\(day!)/\(month!)/\(year!)"
////
////                self.valStartDate = "\(year!)-\(month!)-\(day!)"
////                //            self.startDayAndMonthPopup.text = "\(startday!) Tháng \(startmonth!)"
////                //            self.startDayAndMonth.text = "\(startday!)/\(startmonth!)/\(startyear!)"
////
////
////                if let startDateFormat = dateFormatterGet.date(from: self.startDate!) {
////                    self.startDate = dateFormatterPrint.string(from: startDateFormat)
////                    self.startDayAndMonthPopup.text = self.startDate
////                    self.startDayAndMonth.text = self.startDate
////                    //                    self.txtFormHomeStartDate = self.startDate
////
////                } else {
////                    print("There was an error decoding the string")
////                }
////
////
//////                if let valStartDateFormat = dateFormatterGet.date(from: self.valStartDate!) {
//////                    self.valStartDate = dateFormatterPrint.string(from: valStartDateFormat)
//////                } else {
//////                    print("There was an error decoding the string")
//////                }
////
////            } else {
////                let end = calendar.dateComponents([.year, .month, .day], from: date!)
////
////                let weekday = Calendar.current.component(.weekday, from: date!)
////                let year =  end.year
////                let month = end.month
////                let day = end.day
////
////                self.valEndFormatDate = calendar.date(from:end)
////                self.endDayAndMonth.text = "\(day!) Tháng \(month!)"
////                //                self.valEndDate = "\(day!)-\(month!)-\(year!)"
////                //                self.endDate = "\(day!) Tháng \(month!)"
////                if weekday != 1 {
////                    self.endDayOfWeek.text = "Thứ \(weekday)"
////                } else {
////                    self.endDayOfWeek.text = "Chủ nhật"
////                }
////
////
////                self.endDate = "\(day!)/\(month!)/\(year!)"
////                self.valEndDate = "\(year!)-\(month!)-\(day!)"
////
////                if let endDateFormat = dateFormatterGet.date(from: self.endDate!) {
////                    self.endDate = dateFormatterPrint.string(from: endDateFormat)
////                    self.endDayAndMonthPopup.text = dateFormatterPrint.string(from: endDateFormat)
////                    self.endDayAndMonth.text = dateFormatterPrint.string(from: endDateFormat)
////                } else {
////                    print("There was an error decoding the string")
////                }
////
//////                if let valEndDateFormat = dateFormatterGet.date(from: self.valEndDate!) {
//////                    self.valEndDate = dateFormatterPrint.string(from: valEndDateFormat)
//////                } else {
//////                    print("There was an error decoding the string")
//////                }
////
////            }
////        }
//
//
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "d/M/y"
//
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
//        if date != nil {
//            if choseStartDate {
//                let start = calendar.dateComponents([.year, .month, .day], from: date!)
//                let year =  start.year
//                let month = start.month
//                let day = start.day
//                let weekday = Calendar.current.component(.weekday, from: date!)
//
//
//
//                //                if let valStartDateFormat = dateFormatterGet.date(from: self.valStartDate!) {
//                //                    self.valStartDate = dateFormatterPrint.string(from: valStartDateFormat)
//                //                } else {
//                //                    print("There was an error decoding the string")
//                //                }
//
//                let calendar = Calendar.current
//                let components = calendar.dateComponents([.day], from: Date(), to: calendar.date(from:start)!)
//                if components.day! < 0 {
//                    self.showMessage(title: "Flamingo", message: "Vui lòng chọn ngày nhận từ ngày hiện tại")
//                } else {
//                    self.valStartFormatDate = calendar.date(from:start)
//                    //                self.valEndFormatDate
//                    //                self.startDayAndMonth.text = "\(startday!) Tháng \(startmonth!)"
//                    //                self.startDate = "\(startday!) Tháng \(startmonth!)"
//
//                    //                self.valStartDate = "\(startday!)-\(startmonth!)-\(startyear!)"
//                    if weekday != 1 {
//                        self.startDayOfWeek.text = "Thứ \(weekday)"
//                    } else {
//                        self.startDayOfWeek.text = "Chủ nhật"
//                    }
//
//                    self.startDate = "\(day!)/\(month!)/\(year!)"
//
//                    self.valStartDate = "\(year!)-\(month!)-\(day!)"
//
//
//
//                    if let startDateFormat = dateFormatterGet.date(from: self.startDate!) {
////                        self.startDate = dateFormatterPrint.string(from: startDateFormat)
////                        self.startDayAndMonth.text = dateFormatterPrint.string(from: startDateFormat)
////                        self.txtFormHomeStartDate = self.startDate
//                        self.startDate = dateFormatterPrint.string(from: startDateFormat)
//                        self.startDayAndMonthPopup.text = self.startDate
//                        self.startDayAndMonth.text = self.startDate
//                    } else {
//                        print("There was an error decoding the string")
//                    }
//                    let nextOneDate = Calendar.current.date(byAdding: .day, value: 1, to: date!)
//                    let componentEnđate = calendar.dateComponents([.year, .month, .day], from: nextOneDate!)
//                    self.endDate = "\(day! + 1)/\(month!)/\(year!)"
//                    self.valEndDate = "\(year!)-\(month!)-\(day! + 1)"
//                    if let endDateFormat = dateFormatterGet.date(from: self.endDate!) {
//                        self.endDate = dateFormatterPrint.string(from: endDateFormat)
//                        self.endDayAndMonthPopup.text = dateFormatterPrint.string(from: endDateFormat)
//                        self.endDayAndMonth.text = dateFormatterPrint.string(from: endDateFormat)
//                    } else {
//                        print("There was an error decoding the string")
//                    }
//                    self.valEndFormatDate = calendar.date(from:componentEnđate)
//                }
//
//            } else {
//                let end = calendar.dateComponents([.year, .month, .day], from: date!)
//
//                let weekday = Calendar.current.component(.weekday, from: date!)
//                let year =  end.year
//                let month = end.month
//                let day = end.day
//
//                //                if let valEndDateFormat = dateFormatterGet.date(from: self.valEndDate!) {
//                //                    self.valEndDate = dateFormatterPrint.string(from: valEndDateFormat)
//                //                } else {
//                //                    print("There was an error decoding the string")
//                //                }
//                let calendar = Calendar.current
//                let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: calendar.date(from:end)!)
//                if components.day! < 0 {
//                    self.showMessage(title: "Flamingo", message: "Vui lòng chọn ngày trả sau ngày nhận")
//                } else {
//
//                    self.valEndFormatDate = calendar.date(from:end)
//                    self.endDayAndMonth.text = "\(day!) Tháng \(month!)"
//                    self.valEndDate = "\(day!)-\(month!)-\(year!)"
//                    self.endDate = "\(day!) Tháng \(month!)"
//                    if weekday != 1 {
//                        self.endDayOfWeek.text = "Thứ \(weekday)"
//                    } else {
//                        self.endDayOfWeek.text = "Chủ nhật"
//                    }
//
//                    self.endDate = "\(day!)/\(month!)/\(year!)"
//                    self.valEndDate = "\(year!)-\(month!)-\(day!)"
//
//                    if let endDateFormat = dateFormatterGet.date(from: self.endDate!) {
//                        self.endDate = dateFormatterPrint.string(from: endDateFormat)
//                        self.endDayAndMonthPopup.text = dateFormatterPrint.string(from: endDateFormat)
//                        self.endDayAndMonth.text = dateFormatterPrint.string(from: endDateFormat)
//                    } else {
//                        print("There was an error decoding the string")
//                    }
//
//                }
//            }
//        }
//
//
//
//
//        return true
//    }
//}


extension RoomDetailViewController: CalendarViewDataSource, CalendarViewDelegate {
    
    // MARK : KDCalendarDataSource
    
    func startDate() -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.month = 0
        
        let today = Date()
        
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        
        return threeMonthsAgo
    }
    
    func endDate() -> Date {
        
        var dateComponents = DateComponents()
        
        dateComponents.month = 1000
        let today = Date()
        
        let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        
        return twoYearsFromNow
        
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        let calendar = Calendar.current
        let today = Date()
        let end = calendar.dateComponents([.year, .month, .day], from: date)
        let todayComponent = calendar.dateComponents([.year, .month, .day], from: today)
        let components = calendar.dateComponents([.day], from: calendar.date(from:todayComponent)!, to: calendar.date(from:end)!)
        
        print(components)
        if components.day! >= 0 {
            return true
        }
        return false
    }
    
    // MARK : KDCalendarDelegate
    
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
        
        print("Did Select: \(date) with \(events.count) events")
        for event in events {
            print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
        }
        let calendar = Calendar.current
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "d/M/y"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if choseStartDate {
            let start = calendar.dateComponents([.year, .month, .day], from: date)
            let year =  start.year
            let month = start.month
            let day = start.day
            let weekday = Calendar.current.component(.weekday, from: date)
            
            
            
            //                if let valStartDateFormat = dateFormatterGet.date(from: self.valStartDate!) {
            //                    self.valStartDate = dateFormatterPrint.string(from: valStartDateFormat)
            //                } else {
            //                    print("There was an error decoding the string")
            //                }
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: Date(), to: calendar.date(from:start)!)
            if components.day! < 0 {
                self.showMessage(title: "Flamingo", message: "Vui lòng chọn ngày nhận từ ngày hiện tại")
            } else {
                self.valStartFormatDate = calendar.date(from:start)
                //                self.valEndFormatDate
                //                self.startDayAndMonth.text = "\(startday!) Tháng \(startmonth!)"
                //                self.startDate = "\(startday!) Tháng \(startmonth!)"
                
                //                self.valStartDate = "\(startday!)-\(startmonth!)-\(startyear!)"
                if weekday != 1 {
                    self.startDayOfWeek.text = "Thứ \(weekday)"
                } else {
                    self.startDayOfWeek.text = "Chủ nhật"
                }
                
                self.startDateStr = "\(day!)/\(month!)/\(year!)"
                
                self.valStartDate = "\(year!)-\(month!)-\(day!)"
                
                
                
                if let startDateFormat = dateFormatterGet.date(from: self.startDateStr!) {
                    self.startDateStr = dateFormatterPrint.string(from: startDateFormat)
                    self.startDayAndMonthPopup.text = self.startDateStr
                    self.startDayAndMonth.text = self.startDateStr
                } else {
                    print("There was an error decoding the string")
                }
                let nextOneDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
                let componentEnđate = calendar.dateComponents([.year, .month, .day], from: nextOneDate!)
                self.endDateStr = "\(day! + 1)/\(month!)/\(year!)"
                self.valEndDate = "\(year!)-\(month!)-\(day! + 1)"
                if let endDateFormat = dateFormatterGet.date(from: self.endDateStr!) {
                    self.endDateStr = dateFormatterPrint.string(from: endDateFormat)
                    self.endDayAndMonthPopup.text = dateFormatterPrint.string(from: endDateFormat)
                    self.endDayAndMonth.text = dateFormatterPrint.string(from: endDateFormat)
                } else {
                    print("There was an error decoding the string")
                }
                self.valEndFormatDate = calendar.date(from:componentEnđate)
            }
        } else {
            let end = calendar.dateComponents([.year, .month, .day], from: date)
            
            let weekday = Calendar.current.component(.weekday, from: date)
            let year =  end.year
            let month = end.month
            let day = end.day
            
            //                if let valEndDateFormat = dateFormatterGet.date(from: self.valEndDate!) {
            //                    self.valEndDate = dateFormatterPrint.string(from: valEndDateFormat)
            //                } else {
            //                    print("There was an error decoding the string")
            //                }
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: calendar.date(from:end)!)
            if components.day! < 0 {
                self.showMessage(title: "Flamingo", message: "Vui lòng chọn ngày trả sau ngày nhận")
            } else {
                
                self.valEndFormatDate = calendar.date(from:end)
                self.endDayAndMonth.text = "\(day!) Tháng \(month!)"
                self.valEndDate = "\(day!)-\(month!)-\(year!)"
                self.endDateStr = "\(day!) Tháng \(month!)"
                if weekday != 1 {
                    self.endDayOfWeek.text = "Thứ \(weekday)"
                } else {
                    self.endDayOfWeek.text = "Chủ nhật"
                }
                
                self.endDateStr = "\(day!)/\(month!)/\(year!)"
                self.valEndDate = "\(year!)-\(month!)-\(day!)"
                
                if let endDateFormat = dateFormatterGet.date(from: self.endDateStr!) {
                    self.endDateStr = dateFormatterPrint.string(from: endDateFormat)
                    self.endDayAndMonthPopup.text = dateFormatterPrint.string(from: endDateFormat)
                    self.endDayAndMonth.text = dateFormatterPrint.string(from: endDateFormat)
                } else {
                    print("There was an error decoding the string")
                }
                
            }
        }
        
        
    }
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {
        
    }
    
    
    func calendar(_ calendar: CalendarView, didLongPressDate date : Date, withEvents events: [CalendarEvent]?) {
        
        //        if let events = events {
        //            for event in events {
        //                print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
        //            }
        //        }
        //
        //        let alert = UIAlertController(title: "Create New Event", message: "Message", preferredStyle: .alert)
        //
        //        alert.addTextField { (textField: UITextField) in
        //            textField.placeholder = "Event Title"
        //        }
        //
        //        let addEventAction = UIAlertAction(title: "Create", style: .default, handler: { (action) -> Void in
        //            let title = alert.textFields?.first?.text
        //            self.calendarView.addEvent(title!, date: date)
        //        })
        //
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        //
        //        alert.addAction(addEventAction)
        //        alert.addAction(cancelAction)
        //
        //        self.present(alert, animated: true, completion: nil)
        
    }
    
}

