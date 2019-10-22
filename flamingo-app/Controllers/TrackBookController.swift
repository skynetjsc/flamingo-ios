//
//  TrackBookController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/18/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift

class TrackBookController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var listBook = [[String: Any]]()
    
    var listBookItem = [String: Any]()
    var BookingID: String?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var segementedTrack: UISegmentedControl!
    
    let segmentGrayColor = UIColor(red: 0.889415, green: 0.889436, blue:0.889424, alpha: 1.0 )
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSegemented()
        
    }
    
    func setupSegemented() {
        segementedTrack.backgroundColor = .clear
        segementedTrack.tintColor = .clear
        
        segementedTrack.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
            ], for: .normal)
        
        segementedTrack.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.orange
            ], for: .selected)
        
        segementedTrack.layer.borderWidth = 1
        segementedTrack.layer.borderColor = segmentGrayColor.cgColor
        segementedTrack.layer.masksToBounds = true
        
        for (index,element) in segementedTrack.subviews.enumerated() {
            element.addBorder(toSide: .Left, withColor: segmentGrayColor.cgColor, andThickness: 1, height: 50)
        }
        
        segementedTrack.selectedSegmentIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if segementedTrack.selectedSegmentIndex == 0 {
            self.getListBook("0")
        }
        if segementedTrack.selectedSegmentIndex == 1 {
            self.getListBook("10")
        }
        if segementedTrack.selectedSegmentIndex == 2 {
            self.getListBook("1")
        }
        if segementedTrack.selectedSegmentIndex == 3 {
            self.getListBook("5")
        }
    }
    @IBAction func segueValueChange(_ sender: Any) {
        if segementedTrack.selectedSegmentIndex == 0 {
            self.getListBook("0")
        }
        if segementedTrack.selectedSegmentIndex == 1 {
            self.getListBook("10")
        }
        if segementedTrack.selectedSegmentIndex == 2 {
            self.getListBook("1")
        }
        if segementedTrack.selectedSegmentIndex == 3 {
            self.getListBook("5")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listBook.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as! TrackCollectionViewCell

        cell.imageItem.layer.cornerRadius = 15
        cell.imageItem.clipsToBounds = true
        if #available(iOS 11.0, *) {
            cell.imageItem.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        cell.bgView.layer.cornerRadius = 15
//        cell.bgView.clipsToBounds = true
//        if #available(iOS 11.0, *) {
//            cell.bgView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMaxYCorner]
//        } else {
//            // Fallback on earlier versions
//        }
        
        cell.imageItem.downloaded(from: (self.listBook[indexPath.row]["Picture1"]  as? String)!)
        cell.imageItem.contentMode = .scaleAspectFill
        cell.title.text = self.listBook[indexPath.row]["PropertyRoomName"] as? String
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "vi_VN")
        cell.price.text = numberFormatter.string(from: NSNumber(value: self.listBook[indexPath.row]["RoomPrice"] as! Double))!
//        cell.price.text = "\(String(describing: self.listBook[indexPath.row]["RoomPrice"]!))"
        cell.rating.text = "\(String(describing: self.listBook[indexPath.row]["AverageVote"]!)) / \(String(describing: self.listBook[indexPath.row]["CountVote"]!)) đánh giá"
        
        if self.listBook[indexPath.row]["Status"] as! Int == 5 {
            cell.imageStatus.image = UIImage(named: "paid_cancel")
        } else {
            cell.imageStatus.image = UIImage(named: "paid")
        }
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        var startDate: Date?
        var endDate: Date?
        
        if let endDateFormat = dateFormatterGet.date(from: String(describing: self.listBook[indexPath.row]["CheckOutDate"]!)) {
            endDate = endDateFormat
        }
        if let startDateFormat = dateFormatterGet.date(from: String(describing: self.listBook[indexPath.row]["CheckInDate"]!)) {
            startDate = startDateFormat
        }
        
        let calendar = Calendar.current
        
        
        let start = calendar.dateComponents([.year, .month, .day], from: startDate!)
        let end = calendar.dateComponents([.year, .month, .day], from: endDate!)
        
        let components = calendar.dateComponents([.day], from: calendar.date(from:start)!, to: calendar.date(from:end)!)
        
        cell.time.text = "/\(components.day!) đêm"
        
        
        
        return cell
    }
    
    func getListBook(_ status: String) {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        var username = ""
        if currentUser["LoginName"] != nil {
            username = currentUser["LoginName"] as! String
        }
        
        let params = [
            "Username": currentUser["LoginName"],
            "DeviceID": UIDevice.current.identifierForVendor!.uuidString,
            "Status": status
            ] as [String : Any]
        self.showProgress()
        BaseService.shared.listBookHistory(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            print(response)
            if status {
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                        if let result = response["Data"] as? [[String: Any]] {
                            self.listBook = result
                            
                        }
                        
                        self.collectionView.reloadData()
                        
                    })
                    
                    
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print(self.listBook[indexPath.row])
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "DetailTrackViewController") as! DetailTrackViewController
//        controller.listBook = self.listBook[indexPath.row]
//        controller.BookingID = "\(String(describing: self.listBook[indexPath.row]["BookingID"]!))"
//        self.navigationController?.pushViewController(controller, animated: true)
        self.listBookItem = self.listBook[indexPath.row]
        self.BookingID = "\(String(describing: self.listBook[indexPath.row]["BookingID"]!))"
        self.performSegue(withIdentifier: "showDetailTrack", sender: nil)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailTrack" {
            if let viewController: DetailTrackViewController = segue.destination as? DetailTrackViewController {
                viewController.listBook = self.listBookItem
                viewController.BookingID = self.BookingID!
            }
        }
    }
    
    
    
    
    @IBAction func menuButtonDidClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
//        self.present(newViewController, animated: true, completion: nil)
    }
    
}
