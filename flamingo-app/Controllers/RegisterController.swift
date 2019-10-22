//
//  RegisterController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/19/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//


import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import SideMenuSwift

class RegisterController: BaseViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var userName: TextField!
    @IBOutlet weak var password: TextField!
    
    var UserInfoID: String?
    var VerifyCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func register(_ sender: Any) {
        
        let name: String? = self.userName.text
        let pass: String? = self.password.text
        
        let paramVerify = [
            "Telephone": name,
            "VerifyType": "0"
        ]
        
        BaseService.shared.verifyCode(params: paramVerify as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]!["ID"] {
//                    App.shared.save(value: response as AnyObject, forKey: K_CURRENT_USER_INFO)
//                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuController
//                                        self.present(newViewController, animated: true, completion: nil)
//                    self.showMessage(title: "Flamingo", message: "Đăng ký tài khoản thành công")
                    self.VerifyCode = "\(String(describing: response["Data"]!["VerifyCode"]!!))"
                    self.performSegue(withIdentifier: "verifyOTP", sender: nil)
                } else {
                    self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                }
                
            } else {
                self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verifyOTP" {
            if let viewController: VerifyIOTPViewController = segue.destination as? VerifyIOTPViewController {
                viewController.Telephone = self.userName.text
                viewController.Password = self.password.text
                viewController.VerifyCode = self.VerifyCode!
            }
        } else if segue.identifier == "loginSocial" {
            if let viewController: UpdateFullNameViewController = segue.destination as? UpdateFullNameViewController {
                viewController.Telephone = ""
                viewController.LoginSocail = true
                viewController.Password = ""
                viewController.UserInfoID = self.UserInfoID!
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
                        print("\(String(describing: response["Data"]!["ID"]!!))")
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
        

    
}
