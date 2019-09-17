//
//  ListSearchViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/23/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import VisualEffectView
import Koyomi
//import KDCalendar


class ListSearchViewController: BaseViewController {
    
    

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var listSearch = [[String:Any]]()
    var listSearchMap = [[String:Any]]()
    var PropertyID: String? = nil
    var Content: String = ""
    var CheckInDate: String?
    var CheckOutDate: String?
    
    var txtFormHomeStartDate: String?
    var txtFormHomeEndDate: String?
    var valStartFormatDate: Date?
    var valEndFormatDate: Date?
    
    @IBOutlet weak var calendarView: CalendarView!
    
//    @IBOutlet weak var segementNextMonth: UISegmentedControl!
    
    var startDateStr: String?
    var endDateStr: String?
    
    var valStartDate: String?
    var valEndDate: String?
    
    
    @IBOutlet var viewParent: UIView!
    @IBOutlet var popupChosseDate: UIView!
    @IBOutlet weak var bgPopKoyomi: VisualEffectView!
    @IBOutlet weak var segementedMonth: UISegmentedControl!
    
    @IBOutlet weak var bgPopupChosseDate: VisualEffectView!
    @IBOutlet weak var startDayAndMonth: UILabel!
    @IBOutlet weak var endDayAndMonth: UILabel!
    @IBOutlet weak var startDayOfWeek: UILabel!
    @IBOutlet weak var endDayOfWeek: UILabel!
    
    
    
    
    var choseStartDate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DANH SÁCH TÌM KIẾM"
        // Do any additional setup after loading the view.
        
        self.setViewModal()
//
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
//        calendarView.headerView.isHidden = true
//
//        calendarView.backgroundColor = UIColor(red:250.00, green:250.00, blue:250.00, alpha:1.00)
        
//        let date = Date()
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: date)
//        let year =  components.year
//        let month = components.month
//        let day = components.day
        
//        self.valStartFormatDate = calendar.date(from:components)
//        self.valEndFormatDate = calendar.date(from:components)
//
//        self.startDate = "\(day!) Tháng \(month!)"
//        self.endDate = "\(day!) Tháng \(month!)"
//
//        self.valStartDate = "\(day!)-\(month!)-\(year!)"
//        self.valEndDate = "\(day!)-\(month!)-\(year!)"
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
        } else {
            print("There was an error decoding the string")
        }
        
        if let endDateFormat = dateFormatterGet.date(from: self.endDateStr!) {
            self.endDateStr = dateFormatterPrint.string(from: endDateFormat)
            self.endDayAndMonth.text = dateFormatterPrint.string(from: endDateFormat)
        } else {
            print("There was an error decoding the string")
        }
        
        
        self.valStartDate = "\(startYear!)-\(startMonth!)-\(startDay!)"
        self.valEndDate = "\(endYear!)-\(endMonth!)-\(endDay!)"
        
//        if let valStartDateFormat = dateFormatterGet.date(from: self.valStartDate!) {
//            self.valStartDate = dateFormatterPrint.string(from: valStartDateFormat)
//        } else {
//            print("There was an error decoding the string")
//        }
//
//        if let valEndDateFormat = dateFormatterGet.date(from: self.valEndDate!) {
//            self.valEndDate = dateFormatterPrint.string(from: valEndDateFormat)
//        } else {
//            print("There was an error decoding the string")
//        }
//        let today = Date()
//        self.calendarView.setDisplayDate(today, animated: false)
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let today = Date()
        self.calendarView.setDisplayDate(today, animated: false)
    }
    
    
    @IBAction func chosseDate(_ sender: Any) {
        
        self.choseStartDate = true
        if self.choseStartDate {
            self.startDayOfWeek.isHidden = false
            self.startDayAndMonth.isHidden = false
            self.endDayOfWeek.isHidden = true
            self.endDayAndMonth.isHidden = true
        }
        self.animateIn(popupChosseDate)
    }
    
    
    @IBAction func chosseStartDate(_ sender: Any) {
        self.choseStartDate = false
        if !self.choseStartDate {
            self.startDayOfWeek.isHidden = true
            self.startDayAndMonth.isHidden = true
            self.endDayOfWeek.isHidden = false
            self.endDayAndMonth.isHidden = false
        }
        self.animateIn(popupChosseDate)
    }
    
    
    @IBAction func closeChosseDate(_ sender: Any) {
        self.animateOut(popupChosseDate)
    }
    
    @IBAction func selectDate(_ sender: Any) {
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: self.valEndFormatDate!)
//        if components.day! <= 0 {
//            self.showMessage(title: "Flamingo", message: "Vui lòng chọn lại ngày nhận và trả")
//        } else {
            self.animateOut(popupChosseDate)
            self.getListSearch(true)
            self.tableView.reloadData()
//        }
        
    }
    @IBAction func showListSearchMapp(_ sender: Any) {
        self.listSearchMap = self.listSearch
        self.performSegue(withIdentifier: "showListSearchMap", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListSearchMap" {
            if let viewController: ListSearchMapViewController = segue.destination as? ListSearchMapViewController {
                
                viewController.listSearchMap = self.listSearchMap
            }
        }
    }
    
    @IBAction func segementValueChange(_ sender: Any) {
//        print(segementNextMonth.selectedSegmentIndex)
//        let month: MonthType = {
//            switch segementNextMonth.selectedSegmentIndex {
//            case 0:  return .previous
//            case 1:  return .current
//            default: return .next
//            }
//        }()
//        print(month)
//        koyomi.display(in: month)
    }
    
    func setupKoyomi(){
        
        
        
//        koyomi.circularViewDiameter = 0.5
//        koyomi.calendarDelegate = self as KoyomiDelegate
//        koyomi.inset = UIEdgeInsets(top: 0.5, left: 0.5, bottom: 0.5, right: 0.5)
//        koyomi.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
//        koyomi.dayBackgrondColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0)
//        koyomi.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
//        koyomi.dayPosition = .center
////        koyomi.selectionMode = .sequence(style: .semicircleEdge)
//        koyomi.selectedStyleColor = UIColor(red: 242/255, green: 94/255, blue: 28/255, alpha: 1)
//        koyomi
//            .setDayFont(size: 14)
//            .setWeekFont(size: 0)
//        koyomi.display(in: .next)
    }
    
    func setViewModal() {
        bgPopupChosseDate.colorTintAlpha = 0.7
        bgPopupChosseDate.blurRadius = 3
        bgPopupChosseDate.scale = 1
        
        bgPopKoyomi.colorTintAlpha = 0.7
        bgPopKoyomi.blurRadius = 4
        bgPopKoyomi.scale = 1
        
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
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar.isHidden = true
        })
        
        
    }
    
    func animateOut(_ desiredView: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.alpha = 0
        }) { _ in
            desiredView.removeFromSuperview()
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar.isHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    
    
    
    //GET DATA
    
    func getListSearch(_ refresh: Bool) {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        
        let params = [
            "Username": currentUser["LoginName"]!,
            "PropertyID": "\(self.PropertyID!)",
            "Content" : self.Content,
            "CheckInDate": self.valStartDate!,
            "CheckOutDate": self.valEndDate!
            ] as [String : Any]
        print(params)
        self.showProgress()
        BaseService.shared.searchRoomWidthPropertyID(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let result = response["Data"]! as? [[String:Any]] {
                    DispatchQueue.main.async(execute: {
                        if let jsonData = response["Data"] as? [[String:AnyObject]] {
//                            print(response["Data"]! as! [[String : Any]])
                            self.listSearch = response["Data"]! as! [[String : Any]]
                        }
                        if refresh {
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
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getListSearch(true)
        
        
        let color =   UIColor.init(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 0)
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        self.navigationController?.navigationBar.backgroundColor = color
        UIApplication.shared.statusBarView?.backgroundColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    
}

extension ListSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listSearch.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FormSearchTableViewCell", for: indexPath) as! FormSearchTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.isUserInteractionEnabled = true
            
            cell.txtStartDate.text = self.txtFormHomeStartDate
            cell.txtEndDate.text = self.txtFormHomeEndDate
            cell.callbackSearch = { recived in
                self.Content = recived
                
                self.getListSearch(true)
                
            }
            
            return cell
        } else if row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountRoomTableViewCell", for: indexPath) as! CountRoomTableViewCell
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.isUserInteractionEnabled = false
            
            let main_string = "Chỉ còn \(String(self.listSearch.count)) phòng"
            let string_to_color = "\(String(self.listSearch.count))"
            
            let range = (main_string as NSString).range(of: string_to_color)
            
            let attribute = NSMutableAttributedString.init(string: main_string)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 242/255, green: 94/255, blue: 28/255, alpha: 1) , range: range)
            
            
//            txtfield1 = UITextField.init(frame:CGRect(x:10 , y:20 ,width:100 , height:100))
            cell.txtCountRoom.attributedText = attribute
            
//            cell.txtCountRoom.text = "Chỉ còn \(String(self.listSearch.count)) phòng"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListRoomTableViewCell", for: indexPath) as! ListRoomTableViewCell
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.isUserInteractionEnabled = true
            
            let data = self.listSearch[indexPath.row - 2]
            cell.imageItem.downloaded(from: (data["Picture1"] as? String)!)
            cell.imageItem.contentMode = .scaleAspectFill
            if data["IsFavourite"] as! Int == 0 {
                    cell.icon_like.image = UIImage(named: "heart_white")
            } else {
                cell.icon_like.image = UIImage(named: "heart_like")
            }
            
            cell.nameItem.text = data["PropertyRoomName"] as? String
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = Locale(identifier: "vi_VN")
            cell.priceItem.text = numberFormatter.string(from: NSNumber(value: data["Price"] as! Double))!
//            cell.priceItem.text = String(describing: data["Price"]!)
            cell.ratingItem.rating = data["StarNum"] as! Double
//            cell.countRate.text = "\(String(describing: data["AverageVote"]!))/ \(String(describing: data["CountVote"]!)) đánh giá"
            cell.countRate.text = "8.0/ \(String(describing: data["CountVote"]!)) đánh giá"
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: self.valEndFormatDate!)
            
            cell.countDay.text = "/\(components.day!) đêm"
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(addFavorite(_:)))
            cell.tapViewLike.tag = indexPath.row - 2
            cell.tapViewLike.isUserInteractionEnabled = true
            cell.tapViewLike.addGestureRecognizer(tap)
//            self.tableView.addGestureRecognizer(tap)
            
            return cell
        }
    }
    
    @objc func addFavorite(_ sender: UITapGestureRecognizer) {
        
        let tapView = sender.view
        let tag = tapView?.tag
        
        let indexPath = IndexPath(row: tag! + 2, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! ListRoomTableViewCell

        let data = self.listSearch[tag!]
//        addFavorite
        if data["IsFavourite"] as! Int == 0 {
            let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
            
            let params = [
                "UserName": currentUser["LoginName"],
                "PropertyRoomID": data["ProperRoomID"],
                "IsAdd": "True"
                ] as [String : Any]
            self.showProgress()
            BaseService.shared.addFavorite(params: params as [String : AnyObject]) { (status, response) in
                self.hideProgress()
                if status {
//                    print(response)
                    if let _ = response["Data"] {
                        
                        DispatchQueue.main.async(execute: {
                            if (response["Data"]!["Result"] as! Int == 1) {
                                cell.icon_like.image = UIImage(named: "heart_like")
                                self.getListSearch(false)
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
            
            let params = [
                "UserName": currentUser["LoginName"],
                "PropertyRoomID": data["ProperRoomID"],
                "IsAdd": "False"
                ] as [String : Any]
            self.showProgress()
            BaseService.shared.addFavorite(params: params as [String : AnyObject]) { (status, response) in
                self.hideProgress()
                if status {
//                    print(response)
                    if let _ = response["Data"] {
                        
                        DispatchQueue.main.async(execute: {
                            if (response["Data"]!["Result"] as! Int == 1) {
                                cell.icon_like.image = UIImage(named: "heart_white")
                                self.getListSearch(false)
                            }
                            //                            if (response["Data"]!["BookingID"] != nil) {
                            //                                self.BookingID = "\(String(describing: response["Data"]!["BookingID"]))"
                            //                                self.performSegue(withIdentifier: "paymentViewSuccess", sender: nil)
                            //
                            
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
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 280
        } else if indexPath.row == 1{
            return 44
        } else {
            return 272
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 2 {
            
            let st = UIStoryboard(name: "Main", bundle: nil)
            let vc = st.instantiateViewController(withIdentifier: "showDetailRoom") as! RoomDetailViewController
            
            let id = String(describing: self.listSearch[indexPath.row - 2]["ProperRoomID"]!)
            vc.PropertyRoomID = id
            vc.valStartFormatDate = self.valStartFormatDate
            vc.valEndFormatDate = self.valEndFormatDate
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
}


//extension ListSearchViewController: KoyomiDelegate {
//    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
//    }
//    
//
//    
//    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
//        var calendar = Calendar.current
////        if date != nil {
//////            let nyTimeZone = TimeZone.current
//////            calendar.timeZone = nyTimeZone
////            let start = calendar.dateComponents([.year, .month, .day], from: date!)
////            let startyear =  start.year
////            let startmonth = start.month
////            let startday = start.day
////            let weekday = Calendar.current.component(.weekday, from: date!)
////
////            self.valStartFormatDate = calendar.date(from:start)
////
////
////            self.startDayAndMonth.text = "\(startday!) Tháng \(startmonth!)"
////            self.txtFormHomeStartDate = "\(startday!) Tháng \(startmonth!)"
////
////            self.valStartDate = "\(startday!)-\(startmonth!)-\(startyear!)"
////            if weekday != 1 {
////                self.startDayOfWeek.text = "Thứ \(weekday)"
////            } else {
////                self.startDayOfWeek.text = "Chủ nhật"
////            }
//////            self.getListSearch()
////
////        }
////
////        if toDate != nil {
////            let end = calendar.dateComponents([.year, .month, .day], from: toDate!)
////
////            let weekday = Calendar.current.component(.weekday, from: toDate!)
////            let endyear =  end.year
////            let endmonth = end.month
////            let endday = end.day
////
////            self.valEndFormatDate = calendar.date(from:end)
////            self.endDayAndMonth.text = "\(endday!) Tháng \(endmonth!)"
////            self.valEndDate = "\(endday!)-\(endmonth!)-\(endyear!)"
////            self.txtFormHomeEndDate = "\(endday!) Tháng \(endmonth!)"
////            if weekday != 1 {
////                self.endDayOfWeek.text = "Thứ \(weekday)"
////            } else {
////                self.endDayOfWeek.text = "Chủ nhật"
////            }
////
////        }
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
////                if let valStartDateFormat = dateFormatterGet.date(from: self.valStartDate!) {
////                    self.valStartDate = dateFormatterPrint.string(from: valStartDateFormat)
////                } else {
////                    print("There was an error decoding the string")
////                }
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
//                        self.startDate = dateFormatterPrint.string(from: startDateFormat)
//                        self.startDayAndMonth.text = dateFormatterPrint.string(from: startDateFormat)
//                        self.txtFormHomeStartDate = self.startDate
//                    } else {
//                        print("There was an error decoding the string")
//                    }
//                    let nextOneDate = Calendar.current.date(byAdding: .day, value: 1, to: date!)
//                    let componentEnđate = calendar.dateComponents([.year, .month, .day], from: nextOneDate!)
//                    self.endDate = "\(day! + 1)/\(month!)/\(year!)"
//                    self.valEndDate = "\(year!)-\(month!)-\(day! + 1)"
//                    if let endDateFormat = dateFormatterGet.date(from: self.endDate!) {
//                        self.endDate = dateFormatterPrint.string(from: endDateFormat)
//                        self.txtFormHomeEndDate = self.endDate
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
////                if let valEndDateFormat = dateFormatterGet.date(from: self.valEndDate!) {
////                    self.valEndDate = dateFormatterPrint.string(from: valEndDateFormat)
////                } else {
////                    print("There was an error decoding the string")
////                }
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
//                        self.txtFormHomeEndDate = self.endDate
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
//        
//        return true
//    }
//}
extension ListSearchViewController: CalendarViewDataSource, CalendarViewDelegate {

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
                    self.startDayAndMonth.text = dateFormatterPrint.string(from: startDateFormat)
                    self.txtFormHomeStartDate = self.startDateStr
                } else {
                    print("There was an error decoding the string")
                }
                let nextOneDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
                let componentEnđate = calendar.dateComponents([.year, .month, .day], from: nextOneDate!)
                self.endDateStr = "\(day! + 1)/\(month!)/\(year!)"
                self.valEndDate = "\(year!)-\(month!)-\(day! + 1)"
                if let endDateFormat = dateFormatterGet.date(from: self.endDateStr!) {
                    self.endDateStr = dateFormatterPrint.string(from: endDateFormat)
                    self.txtFormHomeEndDate = self.endDateStr
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
                        self.txtFormHomeEndDate = self.endDateStr
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
