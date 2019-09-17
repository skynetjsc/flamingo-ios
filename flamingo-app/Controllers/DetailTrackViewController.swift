//
//  DetailTrackViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/31/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import Cosmos
import VisualEffectView
class DetailTrackViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    var BookingID: String?
    var listBook = [String: Any]()
    
    @IBOutlet weak var bookID: UILabel!
    @IBOutlet weak var PropertyRoomName: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var CheckInDate: UILabel!
    @IBOutlet weak var RoomCount: UILabel!
    @IBOutlet weak var Adult: UILabel!
    @IBOutlet weak var Child: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    @IBOutlet weak var GrandTotal: UILabel!
    @IBOutlet weak var CheckOutDate: UILabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var imageHeader: UIImageView!
    
    @IBOutlet weak var blurRating: VisualEffectView!
    @IBOutlet var viewRating: UIView!
    @IBOutlet var viewParent: UIView!
    var checkInDate: Date?
    var checkOutDate: Date?
    var PropertyRoomID: String?
    @IBOutlet weak var btnRating: UIButton!
    
    @IBOutlet weak var starRate: CosmosView!
    @IBOutlet weak var commentRate: UITextView!
    
    var ListUtilities = [[String: Any]]()
    
    @IBOutlet weak var collectionViewUtilities: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "CHI TIẾT ĐẶT PHÒNG"
        
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backNav(_:)))
//        self.navigationItem.leftBarButtonItem = newBackButton

//        let button: UIButton = UIButton(type: .custom)
//        //set image for button
//        button.setImage(UIImage(named: "btn_back"), for: .normal)
//        //add function for button
//        button.addTarget(self, action: #selector(backNav(_:)), for: .touchUpInside)
//        //set frame
//        button.frame = CGRect(x: 0, y: 0, width: 30, height: 31)
//
//        let barButton = UIBarButtonItem(customView: button)
//
//        //assign button to navigationbar
//        self.navigationItem.leftBarButtonItem = barButton
        
        self.collectionViewUtilities.delegate = self
        self.collectionViewUtilities.dataSource = self
    }
    
    @objc func backNav(_ sender: UIBarButtonItem) {
//        if BookingID.elementsEqual("0") {
//            _ = navigationController?.popViewController(animated: true)
//        }
        
//        if BookingID != nil{
//            guard let navigationController = sideMenuController?.contentViewController as? UINavigationController else {
//                return
//            }
//            guard let viewController = storyboard?.instantiateViewController(withIdentifier: "TrackBookController") as? NavigationController else {
//                return
//            }
//            navigationController.present(viewController, animated: true, completion: nil)
//
//
//
//        } else {
            _ = navigationController?.popViewController(animated: true)
//        }
        
        blurRating.colorTintAlpha = 0.7
        blurRating.blurRadius = 3
        blurRating.scale = 1
    }
    
//    @IBAction func backAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        if BookingID == nil {
//            self.imageHeader.downloaded(from: (self.listBook["Picture1"]  as? String)!)
//            self.imageHeader.contentMode = .scaleAspectFill
//
//            self.imageHeader.layer.cornerRadius = 15
//            self.imageHeader.clipsToBounds = true
//            if #available(iOS 11.0, *) {
//                self.imageHeader.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//            } else {
//                // Fallback on earlier versions
//            }
//
//
//            let dateFormatterGet = DateFormatter()
//            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//            let dateFormatterPrint = DateFormatter()
//            dateFormatterPrint.dateFormat = "dd/MM/yyyy"
//
//
//            if let CheckInDate = dateFormatterGet.date(from: (self.listBook["CheckInDate"]  as? String)!) {
//                print(dateFormatterPrint.string(from: CheckInDate))
//                self.CheckInDate.text = dateFormatterPrint.string(from: CheckInDate)
//            } else {
//                self.CheckInDate.text = self.listBook["CheckInDate"] as? String
//            }
//
//            if let CheckOutDate = dateFormatterGet.date(from: (self.listBook["CheckOutDate"]  as? String)!) {
//                print(dateFormatterPrint.string(from: CheckOutDate))
//                self.CheckOutDate.text = dateFormatterPrint.string(from: CheckOutDate)
//            } else {
//                self.CheckOutDate.text = self.listBook["CheckOutDate"] as? String
//            }
//
//
//            self.bookID.text = "MÃ ĐẶT PHÒNG:\(String(describing: self.listBook["BookingID"]!))"
//            self.PropertyRoomName.text = self.listBook["PropertyRoomName"] as? String
//            self.rating.rating = self.listBook["StarNum"] as! Double
////            self.CheckInDate.text = self.listBook["CheckInDate"] as? String
////            self.CheckOutDate.text = self.listBook["CheckOutDate"] as? String
//            self.RoomCount.text = ""
//
//            self.Adult.text = "\(String(describing: self.listBook["Adult"]!))"
//            self.Child.text = "\(String(describing: self.listBook["Child"]!))"
//            self.Description.text = self.listBook["Description"] as? String
//            self.GrandTotal.text = "\(String(describing: self.listBook["GrandTotal"]!))"
//
            if self.listBook["Status"] as! Int == 5 {
                self.btnCancel.isHidden = true
                self.btnRating.isHidden = true
            } else {
                self.btnRating.isHidden = false
                self.btnCancel.isHidden = false
            }
//
//        } else {
            self.getBook()
//        }
        
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
    
    func getBook() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "Username": currentUser["LoginName"],
            "BookingID": self.BookingID!
            ] as [String : Any]
        self.showProgress()
        BaseService.shared.bookDetail(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                if let _ = response["Data"]{
                    DispatchQueue.main.async(execute: {
                        
                        if let result = response["Data"] as? [String: Any] {
                            
                            let dateFormatterGet = DateFormatter()
                            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            
                            let dateFormatterPrint = DateFormatter()
                            dateFormatterPrint.dateFormat = "dd/MM/yyyy"
                            
                            
                            if let CheckInDate = dateFormatterGet.date(from: (result["CheckInDate"]  as? String)!) {
                                self.checkInDate = CheckInDate
                                print(dateFormatterPrint.string(from: CheckInDate))
                                self.CheckInDate.text = dateFormatterPrint.string(from: CheckInDate)
                            } else {
                                self.CheckInDate.text = result["CheckInDate"] as? String
                            }
                            
                            if let CheckOutDate = dateFormatterGet.date(from: (result["CheckOutDate"]  as? String)!) {
                                self.checkOutDate = CheckOutDate
                                print(dateFormatterPrint.string(from: CheckOutDate))
                                self.CheckOutDate.text = dateFormatterPrint.string(from: CheckOutDate)
                            } else {
                                self.CheckOutDate.text = result["CheckOutDate"] as? String
                            }
                            
                            self.imageHeader.downloaded(from: (result["Picture1"]  as? String)!)
                            self.imageHeader.contentMode = .scaleAspectFill
                            self.bookID.text = result["BookingID"] as? String
                            self.PropertyRoomName.text = result["PropertyRoomName"] as? String
                            self.rating.rating = result["StarNum"] as! Double
                            //                            self.CheckInDate.text = result[0]["CheckInDate"] as? String
                            //                            self.CheckOutDate.text = result[0]["CheckOutDate"] as? String
                            self.RoomCount.text = "\(String(describing: result["Quantity"]!))"

                            self.Adult.text = "\(String(describing: result["Adult"]!))"
                            self.Child.text = "\(String(describing: result["Child"]!))"
                            self.Description.text = result["Description"] as? String
//                            self.GrandTotal.text = "\(String(describing: result["GrandTotal"]!))"
                            let numberFormatter = NumberFormatter()
                            numberFormatter.numberStyle = .currency
                            numberFormatter.locale = Locale(identifier: "vi_VN")
                            self.GrandTotal.text = numberFormatter.string(from: NSNumber(value: result["GrandTotal"] as! Double))!
                            
                            self.PropertyRoomID = "\(String(describing: result["PropertyRoomID"]!))"
                            self.getDetailRoom()
                            self.collectionViewUtilities.reloadData()

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
    
    func getDetailRoom() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        
        let params = [
            "Username": currentUser["LoginName"],
            "PropertyRoomID": self.PropertyRoomID!
//            "CheckInDate": self.valStartDate!,
//            "CheckOutDate": self.valEndDate!
            ] as [String : Any]
        self.showProgress()
        BaseService.shared.detailRoom(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"] {
                    DispatchQueue.main.async(execute: {
                        
//                        if let infoDetail = response["Data"] as? [String: Any] {
//                            self.infoDetailRoom = infoDetail
//                        }
//                        if let listPicture = response["Data"]!["ListPictures"] as? [[String: Any]] {
//                            self.listPictures = listPicture
//
//                        }
                        
                        if let listUtilities = response["Data"]!["ListUtilities"] as? [[String: Any]] {
                            self.ListUtilities = listUtilities
                        }
//                        if let listVotes = response["Data"]!["ListVote"] as? [[String: Any]] {
//                            self.ListVotes = listVotes
//                        }
//
//                        self.countRate.text = "\(String(describing: self.infoDetailRoom!["AverageVote"]!))/ \(String(describing: self.infoDetailRoom!["CountVote"]!)) đánh giá"
//                        if self.infoDetailRoom!["IsFavourite"] as! Int == 0 {
//                            self.icon_like.image = UIImage(named: "heart_white")
//                        } else {
//                            self.icon_like.image = UIImage(named: "heart_like")
//                        }
//                        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addFavorite(_:)))
//                        self.tapViewLike.isUserInteractionEnabled = true
//                        self.tapViewLike.addGestureRecognizer(tap)
//
//                        self.imageHeader.downloaded(from: (self.listPictures[0]["Picture"] as? String)!)
//                        self.imageHeader.contentMode = .scaleAspectFill
//
                        print(self.ListUtilities)
                        self.collectionViewUtilities.reloadData()
                    })
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.getUserInfo()
        self.getListReceipt()
    }
    
    func getUserInfo() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "ID": currentUser["ID"]
            ] as [String : Any]
        BaseService.shared.getUserInfo(params: params as [String : AnyObject]) { (status, response) in
            
            if status {
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                        App.shared.save(value: response["Data"] as AnyObject, forKey: "USER_INFO")
                        let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
                        
                        let point = userInfo["Point"]!
                        
                    })
                    
                    
                }
            }
        }
    }
    
    func getListReceipt() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        
        let params = [
            "Username": currentUser["LoginName"]!
            ] as [String : Any]
        BaseService.shared.vipCardInfo(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                    })
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    @IBAction func bookContinue(_ sender: Any) {
        
        self.performSegue(withIdentifier: "bookContinue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookContinue" {
            if let vc: RoomDetailViewController = segue.destination as? RoomDetailViewController {
                var calendar = Calendar.current
                let valStartFormatDate = calendar.dateComponents([.year, .month, .day], from: self.checkInDate!)
                let valEndFormatDate = calendar.dateComponents([.year, .month, .day], from: self.checkOutDate!)
                vc.PropertyRoomID = self.PropertyRoomID!
                vc.valStartFormatDate = calendar.date(from:valStartFormatDate)
                vc.valEndFormatDate = calendar.date(from:valEndFormatDate)
            }
        }
    }
    
    @IBAction func cancelBooking(_ sender: Any) {
        
        
        let refreshAlert = UIAlertController(title: "XÁC NHẬN HUỶ PHÒNG", message: "Bạn chắc chắn muốn huỷ phòng này", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            let params = [
                "BookingID": self.listBook["BookingID"]!
                ] as [String : Any]
            self.showProgress()
            BaseService.shared.cancelRoom(params: params as [String : AnyObject]) { (status, response) in
                self.hideProgress()
                print(response)
                if status {
                    if let _ = response["Data"] {
                        
                        DispatchQueue.main.async(execute: {
                            let result = response["Data"] as! [[String: Any]]
                            print(result)
                            if (result[0]["BookingID"] != nil) {
                                self.getUserInfo()
                                self.btnCancel.isHidden = true
                                let alert = UIAlertController(title: "Flamingo", message: "Huỷ đặt phòng thành công", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                                    self.navigationController?.popViewController(animated: true)
                                }))
                                self.present(alert, animated: true)
                                
                            } else {
                                self.showMessage(title: "Flamingo", message: "Huỷ đặt phòng không thành công")
                            }
                        })
                        
                        
                    } else {
                        self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                    }
                    
                } else {
                    self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                }
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Quay lại", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func ratingBook(_ sender: Any) {
        self.animateIn(self.viewRating)
    }
    
    
    @IBAction func closeModal(_ sender: Any) {
        self.animateOut(self.viewRating)
    }
    
    @IBAction func sendRating(_ sender: Any) {
        
        
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "Username": currentUser["LoginName"],
//            "PropertyID": self.BookingID!,
            "PropertyRoomID": self.PropertyRoomID,
            "Notes": self.commentRate.text,
            "Star": self.starRate.rating
            ] as [String : Any]
        
        self.showProgress()
        BaseService.shared.ratingRoom(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
//                    DispatchQueue.main.async(execute: {
//
//                        if let result = response["Data"] as? [String: Any] {
//                            self.animateOut(self.viewRating)
//                            self.showMessage(title: "Flamingo", message: "Đánh giá thành công")
//                        }
//
//
//                    })
                    let alert = UIAlertController(title: "Flamingo", message: "Đánh giá thành công", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        
                        self.animateOut(self.viewRating)
                    }))
                    self.present(alert, animated: true)
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
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
    
}
