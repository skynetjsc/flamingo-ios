//
//  PaymentSuccessViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/27/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift

class PaymentSuccessViewController: UIViewController {

    var BookingID: String?
    var NumberVisaOrPoint: String?
    
    @IBOutlet weak var textNumber: UILabel!
    @IBOutlet weak var imageVisa: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.NumberVisaOrPoint != nil && (self.NumberVisaOrPoint?.elementsEqual("FPOINT"))! {
            self.textNumber.text = "FPOINT"
            imageVisa.isHidden = true
        } else {
            self.textNumber.text = self.NumberVisaOrPoint
            self.imageVisa.image = UIImage(named: "visa_succuss")
        }
        
        self.getUserInfo()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.getUserInfo()
    }
    
    func getUserInfo() {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "ID": currentUser["ID"]
            ] as [String : Any]
        BaseService.shared.getUserInfo(params: params as [String : AnyObject]) { (status, response) in
            
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                        App.shared.save(value: response["Data"] as AnyObject, forKey: "USER_INFO")
                        
                        
                    })
                    
                    
                }
            }
        }
    }
    


    @IBAction func goToTrackBook(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailTrackPaymentViewController") as! DetailTrackPaymentViewController
        controller.BookingID = self.BookingID!
        print(self.BookingID!)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}