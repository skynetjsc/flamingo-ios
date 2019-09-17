//
//  GGMapTableViewCell.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/5/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GGMapTableViewCell: UITableViewCell, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var viewMap: UIView!
    
    
    var googleMaps: GMSMapView!
    var locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.showCurrentLocationOnMap()
        self.locationManager.stopUpdatingLocation()
    }
    
    func showCurrentLocationOnMap() {
        GMSServices.provideAPIKey("AIzaSyDrtJzFQtIse43GgeTQheWjjUReiM14rjE")
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
//        latitude: 21.33955, longitude: 105.717406
        let camera = GMSCameraPosition.camera(withLatitude: 21.33955, longitude: 105.717406, zoom: 15)
        self.googleMaps = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
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
//        self.viewMap.addSubview(self.googleMaps)
//        self.addSubview(self.googleMaps)
        self.viewMap = self.googleMaps
        self.googleMaps.camera = camera
//        self.addSubview(self.buttonCurrentLoc)
    }

}
