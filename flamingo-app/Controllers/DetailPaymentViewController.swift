//
//  DetailPaymentViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/24/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import Koyomi
import VisualEffectView
import Cosmos

class DetailPaymentViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var PropertyRoomID: String?
    var countCapacity: Int?
    var countAdult: Int?
    var countChild: Int?
    var startDateStr: String?
    var endDateStr: String?
    
    var valStartDate: String?
    var valEndDate: String?
    
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var koyomi: Koyomi!
    @IBOutlet weak var bgPopupChosseDate: VisualEffectView!
    @IBOutlet weak var segementedMonth: UISegmentedControl!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtName: UILabel!
    
    @IBOutlet var viewParent: UIView!
    @IBOutlet weak var bgPopKoyomi: VisualEffectView!
    @IBOutlet var popupChosseDate: UIView!
    @IBOutlet weak var startDayAndMonth: UILabel!
    @IBOutlet weak var endDayAndMonth: UILabel!
    @IBOutlet weak var startDayAndMonthPopup: UILabel!
    @IBOutlet weak var endDayAndMonthPopup: UILabel!
    @IBOutlet weak var startDayOfWeek: UILabel!
    
    @IBOutlet weak var endDayOfWeek: UILabel!
    // Capacity
    @IBOutlet weak var incrementCapacity: UIButton!
    @IBOutlet weak var decrementCapacity: UIButton!
    @IBOutlet weak var txtCapacity: UILabel!
    
    
    @IBOutlet weak var incrementAdult: UIButton!
    @IBOutlet weak var decrementAdult: UIButton!
    @IBOutlet weak var txtAdult: UILabel!
    
    
    @IBOutlet weak var incrementChild: UIButton!
    @IBOutlet weak var decrementChild: UIButton!
    @IBOutlet weak var txtChild: UILabel!
    @IBOutlet weak var countDay: UILabel!
    
    @IBOutlet weak var rating: CosmosView!
    
    var valStartFormatDate: Date?
    var valEndFormatDate: Date?
    
    var choseStartDate = true
    
//    @IBOutlet weak var segementNextMonth: UISegmentedControl!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var collectionViewUtilities: UICollectionView!
    
    
//    var countCapacity = 0
//    var countAdult = 0
//    var countChild = 0
    var infoDetailRoom = [String: Any]()
    var listPictures = [[String: Any]]()
    var ListUtilities = [[String: Any]]()
    var showListPicture = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionViewUtilities.delegate = self
        self.collectionViewUtilities.dataSource = self
        self.setViewModal()
        self.setupKoyomi()
        self.txtCapacity.text = String(self.countCapacity!)
        self.txtAdult.text = String(self.countAdult!)
        self.txtChild.text = String(self.countChild!)
        self.decrementCapacity.isEnabled = false
        self.decrementAdult.isEnabled = false
        self.decrementChild.isEnabled = false
        
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewImageScreen(_:)))
        self.imageHeader.addGestureRecognizer(tapGesture)
        self.imageHeader.isUserInteractionEnabled = true
    }
    
//    @IBAction func segementedValueChange(_ sender: Any) {
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
//    }
    
    
    
    @objc func viewImageScreen(_ sender: UITapGestureRecognizer) {
        self.showListPicture = self.listPictures
        self.performSegue(withIdentifier: "showImage", sender: nil)
    }
    
    @IBAction func book(_ sender: Any) {
        if countCapacity == 0 {
            self.showMessage(title: "Flamingo", message: "Vui lòng chọn số lượng phòng!")
        } else {
            self.performSegue(withIdentifier: "PaymentInfo", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PaymentInfo" {
            if let viewController: PaymentInfoViewController = segue.destination as? PaymentInfoViewController {
                
                
                viewController.CheckInDate = self.valStartDate!
                viewController.CheckOutDate = self.valEndDate!
                viewController.Adult =  String(describing: self.countAdult!)
                viewController.Child = String(describing: self.countChild!)
                viewController.RoomPrice = String(describing: self.infoDetailRoom["Price"]!)
                viewController.Quantity = String(describing: self.countCapacity!)
                viewController.PropertyRoomID = self.PropertyRoomID!
                
                viewController.GrandTotal = String(self.countCapacity! * (self.infoDetailRoom["Price"]  as! Int))
            }
        } else if segue.identifier == "showImage" {
            if let viewController: ImageFullScreenViewController = segue.destination as? ImageFullScreenViewController {
                viewController.imageArr = self.showListPicture
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ListUtilities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UtilitiesCollectionViewCell", for: indexPath) as! UtilitiesCollectionViewCell
        
        cell.imageUtilities.downloaded(from: self.ListUtilities[indexPath.row]["Picture"] as! String)
        cell.titleUtilities.text = self.ListUtilities[indexPath.row]["Name"] as? String
        
        return cell
    }
    
    func getDetailRoom() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        
        let params = [
            "Username": currentUser["LoginName"],
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
                        if let infoDetail = response["Data"] as? [String: Any] {
                            // Tam tinh total price
                            
                            let calendar = Calendar.current
                            let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: self.valEndFormatDate!)
                            
                            self.countDay.text = "/\(components.day!) đêm"
                            
                            let totalPrice: Double = Double(self.countCapacity! * (self.infoDetailRoom["Price"]  as! Int))
                            let numberFormatter = NumberFormatter()
                            numberFormatter.numberStyle = .currency
                            numberFormatter.locale = Locale(identifier: "vi_VN")
                            self.totalPrice.text = numberFormatter.string(from: NSNumber(value: totalPrice))!
//                            self.totalPrice.text = "\(totalPrice)"
                            
                            
                            self.imageHeader.downloaded(from: (self.listPictures[0]["Picture"] as? String)!)
                            self.imageHeader.contentMode = .scaleAspectFill
                            self.imageHeader.layer.cornerRadius = 15
                            self.imageHeader.clipsToBounds = true
                            if #available(iOS 11.0, *) {
                                self.imageHeader.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                            } else {
                                // Fallback on earlier versions
                            }
                            self.txtName.text = infoDetail["Name"] as? String
                            self.txtPrice.text = numberFormatter.string(from: NSNumber(value: self.infoDetailRoom["Price"]! as! Double))!
//                            self.txtPrice.text = "\(String(describing: self.infoDetailRoom["Price"]!))"
                            self.rating.rating = self.infoDetailRoom["StarNum"] as! Double
                            
                            if self.countCapacity! > 0 {
                                let yourImage: UIImage = UIImage(named: "minus-circle")!
                                self.decrementCapacity.setImage(yourImage, for: .normal)
                                self.decrementCapacity.isEnabled = true
                            } else {
                                let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
                                self.decrementCapacity.setImage(yourImage, for: .normal)
                                self.decrementCapacity.isEnabled = false
                            }
//                            if (self.infoDetailRoom["Allotment"] as? Int)! == self.countCapacity {
//                                let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//                                self.incrementCapacity.setImage(yourImage, for: .normal)
//                                self.incrementCapacity.isEnabled = false
//                            }
                            if self.countAdult! > 0 {
                                let yourImage: UIImage = UIImage(named: "minus-circle")!
                                self.decrementAdult.setImage(yourImage, for: .normal)
                                self.decrementAdult.isEnabled = true
                            } else {
                                let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
                                self.decrementAdult.setImage(yourImage, for: .normal)
                                self.decrementAdult.isEnabled = false
                            }
                            
//                            if (self.infoDetailRoom["MaxAdult"] as? Int)! == self.countAdult! {
//                                let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//                                self.incrementAdult.setImage(yourImage, for: .normal)
//                                self.incrementAdult.isEnabled = false
//                            }
                            if self.countChild! > 0 {
                                let yourImage: UIImage = UIImage(named: "minus-circle")!
                                self.decrementChild.setImage(yourImage, for: .normal)
                                self.decrementChild.isEnabled = true
                            } else {
                                let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
                                self.decrementChild.setImage(yourImage, for: .normal)
                                self.decrementChild.isEnabled = false
                            }
                            
//                            if (self.infoDetailRoom["MaxChild"] as? Int)! == self.countChild {
//                                let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//                                self.incrementChild.setImage(yourImage, for: .normal)
//                                self.incrementChild.isEnabled = false
//                            }
                            
                        }
                        
                        self.collectionViewUtilities.reloadData()
                    
                        self.view.layoutIfNeeded()
                    })
                    self.view.layoutIfNeeded()
                    
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
        self.getDetailRoom()
    }
    
    @IBAction func chosseDate(_ sender: Any) {
        self.choseStartDate = true
        if self.choseStartDate {
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
        self.getDetailRoom()
        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: self.valEndFormatDate!)
//        print(components)
//        let totalPrice = (components.day! + 1) * (self.infoDetailRoom["Price"] as! Int)
//        self.totalPrice.text = "\(totalPrice)"
        
    }
    
    
    @IBAction func incrementCapacity(_ sender: Any) {
//        print(self.infoDetailRoom)
//        if (self.infoDetailRoom["Allotment"] as? Int)! > self.countCapacity! {
            countCapacity = (self.countCapacity! + 1)
            self.txtCapacity.text = String(self.countCapacity!)
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = false
//        }
        if countCapacity! > 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = false
        }
        
//        if (self.infoDetailRoom["Allotment"] as? Int)! == countCapacity {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = false
//        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: self.valEndFormatDate!)
        
        let totalPrice: Double = Double((self.infoDetailRoom["Price"]  as! Int) * self.countCapacity!)
//        self.totalPrice.text = "\(totalPrice)"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "vi_VN")
        self.totalPrice.text = numberFormatter.string(from: NSNumber(value: totalPrice as! Double))!
        
        
    }
    
    @IBAction func decrementCapacity(_ sender: Any) {
        if 0 < self.countCapacity! {
            self.countCapacity = (self.countCapacity! - 1)
            self.txtCapacity.text = String(self.countCapacity!)
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = false
        }
//        if (self.infoDetailRoom["Allotment"] as? Int)! > self.countCapacity! {
//
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = false
//        }
        
        if self.countCapacity == 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementCapacity.setImage(yourImage, for: .normal)
            decrementCapacity.isEnabled = false
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self.valStartFormatDate!, to: self.valEndFormatDate!)
        
        let totalPrice: Double = Double((self.infoDetailRoom["Price"]  as! Int) * self.countCapacity!)
        //        self.totalPrice.text = "\(totalPrice)"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "vi_VN")
        self.totalPrice.text = numberFormatter.string(from: NSNumber(value: totalPrice as! Double))!
        
    }
    
    @IBAction func incrementAdult(_ sender: Any) {
//        if (self.infoDetailRoom["MaxAdult"] as? Int)! > self.countAdult! {
            countAdult = (self.countAdult! + 1)
            self.txtAdult.text = String(self.countAdult!)
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementAdult.setImage(yourImage, for: .normal)
//            incrementAdult.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementAdult.setImage(yourImage, for: .normal)
//            incrementAdult.isEnabled = false
//        }
        if countAdult! > 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = false
        }
        
//        if (self.infoDetailRoom["MaxAdult"] as? Int)! == self.countAdult! {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementAdult.setImage(yourImage, for: .normal)
//            incrementAdult.isEnabled = false
//        }
    }
    
    @IBAction func decrementAdult(_ sender: Any) {
        if 0 < self.countAdult! {
            countAdult = (self.countAdult! - 1)
            self.txtAdult.text = String(self.countAdult!)
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = false
        }
//        if (self.infoDetailRoom["MaxAdult"] as? Int)! > self.countAdult! {
//
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementAdult.setImage(yourImage, for: .normal)
//            incrementAdult.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementCapacity.setImage(yourImage, for: .normal)
//            incrementCapacity.isEnabled = false
//        }
        
        if self.countAdult == 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementAdult.setImage(yourImage, for: .normal)
            decrementAdult.isEnabled = false
        }
    }
    
    @IBAction func decrementChild(_ sender: Any) {
        if 0 < self.countChild! {
            countChild = (self.countChild! - 1)
            self.txtChild.text = String(countChild!)
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = false
        }
//        if (self.infoDetailRoom["MaxChild"] as? Int)! > self.countChild! {
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
//        if (self.infoDetailRoom["MaxChild"] as? Int)! > self.countChild! {
//            countChild! = (self.countChild! + 1)
//            self.txtChild.text = String(self.countChild!)
//            let yourImage: UIImage = UIImage(named: "plus-circle")!
//            incrementChild.setImage(yourImage, for: .normal)
//            incrementChild.isEnabled = true
//        } else {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementChild.setImage(yourImage, for: .normal)
//            incrementChild.isEnabled = false
//        }
        if countChild! > 0 {
            let yourImage: UIImage = UIImage(named: "minus-circle")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = true
        } else {
            let yourImage: UIImage = UIImage(named: "minus-circle-disable")!
            decrementChild.setImage(yourImage, for: .normal)
            decrementChild.isEnabled = false
        }
        
//        if (self.infoDetailRoom["MaxChild"] as? Int)! == self.countChild {
//            let yourImage: UIImage = UIImage(named: "plus-circle-disable")!
//            incrementChild.setImage(yourImage, for: .normal)
//            incrementChild.isEnabled = false
//        }
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
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension DetailPaymentViewController: KoyomiDelegate {
//    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
//        //        print(indexPath)
//        //        print(date as Any)
//    }
//
//    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
//        let calendar = Calendar.current
////        if date != nil {
////            let start = calendar.dateComponents([.year, .month, .day], from: date!)
////            let startyear =  start.year
////            let startmonth = start.month
////            let startday = start.day
////            let weekday = Calendar.current.component(.weekday, from: date!)
////            self.startDayAndMonthPopup.text = "\(startday!) Tháng \(startmonth!)"
////            self.startDayAndMonth.text = "\(startday!)/\(startmonth!)/\(startyear!)"
////            self.valStartDate = "\(startyear!)-\(startmonth!)-\(startday!)"
//////            self.startDate = "\(startday!) Tháng \(startmonth!)"
//////
//////            self.valStartDate = "\(startday!)-\(startmonth!)-\(startyear!)"
////            self.valStartFormatDate = date
////            if weekday != 1 {
////                self.startDayOfWeek.text = "Thứ \(weekday)"
////            } else {
////                self.startDayOfWeek.text = "Chủ nhật"
////            }
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
////            self.valEndFormatDate = toDate
////            self.endDayAndMonth.text = "\(endday!)/\(endmonth!)/\(endyear!)"
////            self.endDayAndMonthPopup.text = "\(endday!) Tháng \(endmonth!)"
//////            self.valEndDate = "\(endday!)-\(endmonth!)-\(endyear!)"
//////            self.endDate = "\(endday!) Tháng \(endmonth!)"
////
////            self.valEndDate = "\(endyear!)-\(endmonth!)-\(endday!)"
////            if weekday != 1 {
////                self.endDayOfWeek.text = "Thứ \(weekday)"
////            } else {
////                self.endDayOfWeek.text = "Chủ nhật"
////            }
////        }
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
//////                    self.txtFormHomeStartDate = self.startDate
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
//////                self.valEndDate = "\(day!)-\(month!)-\(year!)"
//////                self.endDate = "\(day!) Tháng \(month!)"
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
//                        //                        self.startDate = dateFormatterPrint.string(from: startDateFormat)
//                        //                        self.startDayAndMonth.text = dateFormatterPrint.string(from: startDateFormat)
//                        //                        self.txtFormHomeStartDate = self.startDate
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


extension DetailPaymentViewController: CalendarViewDataSource, CalendarViewDelegate {
        
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

