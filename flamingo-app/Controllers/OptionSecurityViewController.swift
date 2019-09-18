//
//  OptionSecurityViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/16/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import BiometricAuthentication

class OptionSecurityViewController: UIViewController {

    var statusTouch: Bool?
    
    @IBOutlet weak var switchTouch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "THIẾT LẬP"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userLoginStore = App.shared.getStringAnyObject(key: "USER_LOGIN")
        var statusTouchID = false
        if userLoginStore["Status"] != nil {
            if (userLoginStore["Status"] != nil && Int(userLoginStore["Status"]! as! NSNumber) != 0) {
                statusTouchID = true
            }
        }
        print(userLoginStore["Status"])
        print(userLoginStore)
        self.switchTouch.setOn(statusTouchID, animated: true)
//        let userLoginTouchID = [
//            "UserName": name,
//            "Password": pass,
//            "Status": statusTouchID
//            ] as [String : Any]
//        App.shared.save(value: userLoginTouchID as AnyObject, forKey: "USER_LOGIN")
    }
    
    @IBAction func changePassword(_ sender: Any) {
        self.performSegue(withIdentifier: "showChangePassword", sender: nil)
    }
    
    @IBAction func touchID(_ sender: Any) {
//       self.confirmTouchID()
    }
    
    
    @IBAction func switchTouchID(_ sender: UISwitch) {
        
        if sender.isOn {
            self.confirmTouchID()
        } else {
            self.switchTouch.setOn(false, animated: true)
            App.shared.remove(key: "USER_LOGIN")
        }
        
        
    }
    
    func confirmTouchID() {
        // Set AllowableReuseDuration in seconds to bypass the authentication when user has just unlocked the device with biometric
        BioMetricAuthenticator.shared.allowableReuseDuration = 30
        
        // start authentication
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { [weak self] (result) in
            
            switch result {
            case .success( _):
                
                // authentication successful
                if #available(iOS 10.0, *) {
                    self?.showLoginSucessAlert()
                    let userLoginStore = App.shared.getStringAnyObject(key: "USER_LOGIN")
                    
                    let userLoginTouchID = [
                        "UserName": userLoginStore["UserName"],
                        "Password": userLoginStore["Password"],
                        "Status": true
                        ] as [String : Any]
                    
                    print(userLoginTouchID)
                    App.shared.save(value: userLoginTouchID as AnyObject, forKey: "USER_LOGIN")
//                    print(statusTouchID)
                    self!.switchTouch.setOn(true, animated: true)
                } else {
                    // Fallback on earlier versions
                }
                
            case .failure(let error):
                self!.switchTouch.setOn(false, animated: true)
                switch error {
                    
                // device does not support biometric (face id or touch id) authentication
                case .biometryNotAvailable:
                    if #available(iOS 10.0, *) {
                        self?.showErrorAlert(message: error.message())
                    } else {
                        // Fallback on earlier versions
                    }
                    
                // No biometry enrolled in this device, ask user to register fingerprint or face
                case .biometryNotEnrolled:
                    if #available(iOS 10.0, *) {
                        self?.showGotoSettingsAlert(message: error.message())
                    } else {
                        // Fallback on earlier versions
                    }
                    
                // show alternatives on fallback button clicked
                case .fallback: break
                    //                    self?.txtUsername.becomeFirstResponder() // enter username password manually
                    
                    // Biometry is locked out now, because there were too many failed attempts.
                // Need to enter device passcode to unlock.
                case .biometryLockedout:
                    self?.showPasscodeAuthentication(message: error.message())
                    
                // do nothing on canceled by system or user
                case .canceledBySystem, .canceledByUser:
                    break
                    
                // show error for any other reason
                default:
                    if #available(iOS 10.0, *) {
                        self?.showErrorAlert(message: error.message())
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
    }
    
    // show passcode authentication
    func showPasscodeAuthentication(message: String) {
        
        BioMetricAuthenticator.authenticateWithPasscode(reason: message) { [weak self] (result) in
            switch result {
            case .success( _):
                if #available(iOS 10.0, *) {
//                    self?.showLoginSucessAlert()
                    
                } else {
                    // Fallback on earlier versions
            } // passcode authentication success
            case .failure(let error):
                print(error.message())
            }
        }
    }
    
}
// MARK: - Alerts
@available(iOS 10.0, *)
extension OptionSecurityViewController {
    
    func showAlert(title: String, message: String) {
        
        let okAction = AlertAction(title: OKTitle)
        let alertController = getAlertViewController(type: .alert, with: title, message: message, actions: [okAction], showCancel: false) { (button) in
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoginSucessAlert() {
        showAlert(title: "Thông báo", message: "Đã xác nhận vân tay thành công")
    }
    
    func showErrorAlert(message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func showGotoSettingsAlert(message: String) {
        let settingsAction = AlertAction(title: "Đi tới cài đặt")
        
        let alertController = getAlertViewController(type: .alert, with: "Lỗi xác thực", message: "Lỗi xác thực vân tay vui lòng kiểm tra lại cài đặt", actions: [settingsAction], showCancel: true, actionHandler: { (buttonText) in
            if buttonText == CancelTitle { return }
            
            // open settings
            let url = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
            
        })
        present(alertController, animated: true, completion: nil)
    }
}
