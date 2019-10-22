//
//  LoginController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/19/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SideMenuSwift
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import BiometricAuthentication
class LoginController: BaseViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    
    
    
    @IBOutlet weak var userName: TextField!
    @IBOutlet weak var password: TextField!
    var UserInfoID: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func login(_ sender: Any) {
        self.showProgress()
        
        let name: String? = self.userName.text
        let pass: String? = self.password.text
        
        let params = [
            "UserName": name,
            "Password": pass
        ]
        BaseService.shared.login(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]?["ID"] as? Int {
//                    let userLoginStore = App.shared.getStringAnyObject(key: "USER_LOGIN")
//                    var statusTouchID = false
//                    if userLoginStore["Status"] != nil {
//                        if (userLoginStore["Status"] != nil) {
//                            statusTouchID = true
//                        }
//                    }
                    let userLoginTouchID = [
                        "UserName": name,
                        "Password": pass,
                        "Status": false
                        ] as [String : Any]
                    App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
                    App.shared.save(value: userLoginTouchID as AnyObject, forKey: "USER_LOGIN")
//                    self.getUserInfo((response["Data"]!["ID"] as? String)!)
                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
                                        newViewController.modalPresentationStyle = .fullScreen
                                        self.present(newViewController, animated: true, completion: nil)
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    
    
    @IBAction func loginTouchID(_ sender: Any) {
        self.confirmTouchID()
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
    
    func confirmTouchID() {
        // Set AllowableReuseDuration in seconds to bypass the authentication when user has just unlocked the device with biometric
        BioMetricAuthenticator.shared.allowableReuseDuration = 30
        
        // start authentication
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { [weak self] (result) in
            
            switch result {
            case .success( _):
                
                // authentication successful
                if #available(iOS 10.0, *) {
                    let userLoginStore = App.shared.getStringAnyObject(key: "USER_LOGIN")
                    print(userLoginStore)
                    
                    if userLoginStore["Status"] != nil {
                        let params = [
                            "UserName": userLoginStore["UserName"],
                            "Password": userLoginStore["Password"]
                        ]
                        print(params)
                        self?.showProgress()
                        BaseService.shared.login(params: params as [String : AnyObject]) { (status, response) in
                            self?.hideProgress()
                            if status {
                                if let _ = response["Data"]?["ID"] as? Int {
                                    App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
                                    newViewController.modalPresentationStyle = .fullScreen
                                    self!.present(newViewController, animated: true, completion: nil)
                                } else {
                                    self!.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                                }
                                
                            } else {
                                self!.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                            }
                        }
                    } else {
                        self?.showErrorAlert(message: "")
                    }
                } else {
                    // Fallback on earlier versions
                }
            
            
                
            case .failure(let error):
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
    
    
    func getUserInfo(_ id: String) {
        let currentUser = App.shared.getStringAnyObject(key: K_CURRENT_USER_INFO)
        let params = [
            "ID": id
            ] as [String : Any]
        BaseService.shared.getUserInfo(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {

                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        App.shared.save(value: response["Data"] as AnyObject, forKey: "USER_INFO")
                        var mName = response["Data"]!["Email"]!!
                        var email = String(describing: mName)
                        App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
                        if email.elementsEqual("<null>") || email.elementsEqual("") {
                            self.UserInfoID = "\(String(describing: response["Data"]!["ID"]!!))"
                            self.performSegue(withIdentifier: "loginSocial", sender: nil)
                        } else {
                            App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
                            newViewController.modalPresentationStyle = .fullScreen
                            self.present(newViewController, animated: true, completion: nil)
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
    
    @IBAction func loginFB(_ sender: Any) {
        self.facebooklogin()
    }
    
    
    func facebooklogin() {
        let fbLoginManager : LoginManager = LoginManager()
        

        fbLoginManager.logIn(permissions: ["email"], from: self, handler: { (result, error) -> Void in

            print("\n\n result: \(result)")
            print("\n\n Error: \(error)")

            if (error == nil) {
                let fbloginresult : LoginManagerLoginResult = result!
                if(fbloginresult.isCancelled) {
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    self.returnUserData()
                    //fbLoginManager.logOut()
                }
            }
        })
    }

    func returnUserData() {
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil) {
                // Process error
                print("\n\n Error: \(error)")
            } else {
                let resultDic = result as! NSDictionary
                print("\n\n  fetched user: \(result)")
                if (resultDic.value(forKey:"name") != nil) {
                    let userName = resultDic.value(forKey:"name")! as! String as NSString?
                    print("\n User Name is: \(userName)")
                }

                if (resultDic.value(forKey:"id") != nil) {
                    let id = resultDic.value(forKey:"id")! as! String as NSString?
                    print("\n User Email is: \(id)")
                    let params = [
                        "FacebookID": id
                    ]
                    BaseService.shared.loginFB(params: params as [String : AnyObject]) { (status, response) in
                        self.hideProgress()
                        if status {
                            if let _ = response["Data"]?["ID"] as? Int {
                                DispatchQueue.main.async(execute: {
                                    self.getUserInfo(String(describing: response["Data"]!["ID"]!!))
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
        })
    }
    
    @IBAction func loginGG(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("We have error sign in user == \(error.localizedDescription)")
        } else {
            if let gmailUser = user {
                print(gmailUser.userID)
                let params = [
                    "GoogleID": gmailUser.userID!
                ]
                BaseService.shared.loginGG(params: params as [String : AnyObject]) { (status, response) in
                    self.hideProgress()
                    if status {
                        if let _ = response["Data"]?["ID"] as? Int {
                            self.getUserInfo(String(describing: response["Data"]!["ID"]!!))
//                            App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
//                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
//                            self.present(newViewController, animated: true, completion: nil)
//                            let userInfo = App.shared.getStringAnyObject(key: "USER_INFO")
//                            var mName = userInfo["Email"]!
//                            var middleName = String(describing: mName)
//                            if middleName.elementsEqual("<null>") || middleName.elementsEqual("") {
//                                self.performSegue(withIdentifier: "loginSocial", sender: nil)
//                            } else {
//                                App.shared.save(value: response["Data"] as AnyObject, forKey: K_CURRENT_USER_INFO)
//                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
//                                self.present(newViewController, animated: true, completion: nil)
//                            }
                        } else {
                            self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                        }
                    } else {
                        self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSocial" {
            if let viewController: UpdateFullNameViewController = segue.destination as? UpdateFullNameViewController {
                viewController.LoginSocail = true
                viewController.Password = ""
                viewController.Telephone = ""
                viewController.UserInfoID = self.UserInfoID!
            }
        }
    }
    
}
// MARK: - Alerts
@available(iOS 10.0, *)
extension LoginController {
    
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
        showAlert(title: "Thông báo", message: "Chưa thiết lập vân tay. Vui lòng đăng nhập bằng phương thức khác!")
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
