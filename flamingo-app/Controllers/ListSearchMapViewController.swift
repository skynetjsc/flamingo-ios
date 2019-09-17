//
//  ListSearchMapViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ListSearchMapViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    var listSearchMap = [[String:Any]]()
    
    @IBOutlet var viewSearch: UIView!
    
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var viewListScroll: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var googleMaps: GMSMapView!
    var locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        GMSServices.provideAPIKey("AIzaSyDrtJzFQtIse43GgeTQheWjjUReiM14rjE")
//        
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: 21.33955, longitude: 105.717406, zoom: 4.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
////        view = mapView
//        
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 21.33955, longitude: 105.717406)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        GMSServices.provideAPIKey("AIzaSyDrtJzFQtIse43GgeTQheWjjUReiM14rjE")
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        //        latitude: 21.33955, longitude: 105.717406
        let camera = GMSCameraPosition.camera(withLatitude: 21.33955, longitude: 105.717406, zoom: 15)
        self.googleMaps = GMSMapView.map(withFrame: CGRect(x: 0,y: 0, width: self.viewMap.frame.size.width, height: self.viewMap.frame.size.height ), camera: camera)
        
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
        //            self.tableViewHeight.constant = self.tableView.contentSize.height
        
        self.viewMap.addSubview(self.googleMaps)
        self.googleMaps.camera = camera
        
        
        viewSearch.frame = CGRect(x: 10, y: 100, width: viewSearch.frame.width - 30, height: viewSearch.frame.height)
        view.addSubview(viewSearch)
//        viewListRoom.frame = CGRect(x: 0, y: view.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//        viewListRoom.frame = CGRect(x: 0, y: self.viewParent.frame.size.height-80, width: self.viewParent.frame.size.width, height: 135)
//        view.addSubview(viewListRoom)
//        self.view.sendSubviewToBack(viewListScroll)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.listSearchMap.count)
        return self.listSearchMap.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListSearchMapCollectionViewCell", for: indexPath) as! ListSearchMapCollectionViewCell
        
        cell.imageItem.downloaded(from: String(describing: (self.listSearchMap[indexPath.row]["Picture1"])!))
        cell.imageItem.contentMode = .scaleAspectFill
        
        cell.titleItem.text = "\(String(describing: self.listSearchMap[indexPath.row]["PropertyRoomName"]!))"
//        cell.price.text = String(describing: self.listSearchMap[indexPath.row]["Price"]!)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "vi_VN")
        cell.price.text = numberFormatter.string(from: NSNumber(value: self.listSearchMap[indexPath.row]["Price"] as! Double))!
        cell.rating.text = "\(String(describing: self.listSearchMap[indexPath.row]["AverageVote"]!))/ \(String(describing: self.listSearchMap[indexPath.row]["CountVote"]!)) đánh giá"
        cell.imageItem.layer.cornerRadius = 15
        cell.imageItem.clipsToBounds = true
        if #available(iOS 11.0, *) {
            cell.imageItem.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        cell.borderView.layer.cornerRadius = 15
        return cell
    }


}
