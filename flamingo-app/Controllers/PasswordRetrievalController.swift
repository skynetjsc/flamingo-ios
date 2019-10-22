//
//  PasswordRetrievalController.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 8/19/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import UIKit

class PasswordRetrievalController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var phone: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hidden Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    @IBAction func getPassword(_ sender: Any) {
        
        if (self.phone.text == nil || self.phone.text == "") {
            self.showMessage(title: "Flamingo", message: "Vui lòng điền đủ thông tin")
        }
        
        let params = [
            "Telephone": self.phone.text!
            ] as [String : Any]
        print(params)
        BaseService.shared.forgotPassword(params: params as [String : AnyObject]) { (status, response) in
            self.hideProgress()
            if status {
                print(response)
                if let _ = response["Data"]{
                    
                    DispatchQueue.main.async(execute: {
                        
                        if let _ = response["Data"]{
                            
                            DispatchQueue.main.async(execute: {
                                
                                let alert = UIAlertController(title: "Flamingo", message: "Đổi mật khẩu thành công", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                                    self.navigationController?.popViewController(animated: true)
                                }))
                                self.present(alert, animated: true)
                                
                            })
                            
                            
                        } else {
                            self.showMessage(title: "Flamingo", message: (response["Message"] as? String)!)
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
