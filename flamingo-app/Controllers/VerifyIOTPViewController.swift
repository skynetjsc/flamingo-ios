//
//  VerifyIOTPViewController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/23/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit
import SVPinView

class VerifyIOTPViewController: BaseViewController {

    var Telephone: String?
    var Password: String?
    var UserInfoID: String?
    var VerifyCode: String?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var code: SVPinView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func VerifyIOTP(_ sender: Any) {
        
        let paramsRegister = [
            "Telephone": Telephone!,
            "Password": Password!
        ]
        
        if VerifyCode == code.getPin() {
            BaseService.shared.register(params: paramsRegister as [String : AnyObject]) { (status, response) in
                self.hideProgress()
                if status {
                    if let _ = response["Data"]!["ID"] {
                        self.UserInfoID = "\(String(describing: response["Data"]!["ID"]!!))"
                        self.performSegue(withIdentifier: "firstLogin", sender: nil)
                    } else {
                        self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
                    }

                } else {
                    self.showMessage(title: "Flamingo", message: "Có lỗi xảy ra")
                }
            }
        } else {
            self.showMessage(title: "Flamingo", message: "Mã xác thực không chính xác")
        }
        
        
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstLogin" {
            if let viewController: UpdateFullNameViewController = segue.destination as? UpdateFullNameViewController {
                viewController.Telephone = Telephone!
                viewController.Password = Password!
                viewController.UserInfoID = self.UserInfoID!
            }
        }
    }
    
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
        
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
}
