//
//  BaseViewController.swift
//  Stindy
//
//  Created by Nguyễn Chí Thành on 5/5/19.
//  Copyright © 2019 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    typealias Callback = () -> Void
    var disabledTapSelfDismiss: Bool! {
        didSet{
            if self.disabledTapSelfDismiss && self.tap != nil{
                self.view.removeGestureRecognizer(self.tap)
            }
        }
    }
    
    var tap: UITapGestureRecognizer!
    var didTapSelfView: Callback!
    // MARK: NAVIGATION
    var isShowNavigation: Bool! {
        didSet{
            if isShowNavigation {
                self.navigationController?.setNavigationBarHidden(false, animated: false)
            } else {
                self.navigationController?.setNavigationBarHidden(true, animated: false)
            }
        }
    }
    
    // MARK: STATUS BAR
    var isLightStatusBar: Bool! {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    var isHiddenStatusBar: Bool! {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return (self.isLightStatusBar != nil && self.isLightStatusBar) ? .lightContent : .default
    }
    override var prefersStatusBarHidden: Bool {
        return (self.isHiddenStatusBar != nil && self.isHiddenStatusBar) ? true : false
    }
    
    var cookie = UserDefaults.standard
    var textField: UITextField?
    var hud: MBProgressHUD?
    
    
    // MARK: LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isLightStatusBar = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tap = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        self.tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(self.tap)
    }
    
    @objc func tapDismiss(){
        self.view.endEditing(true)
        if self.didTapSelfView != nil {
            self.didTapSelfView()
        }
    }
    // MARK: TABBAR
    func showTabbar(){
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
    }
    func hideTabbar(){
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = true
    }
    func randomGenerate(min: Int, max: Int, count: Int) -> [Int] {
        var numbers: [Int] = []
        if numbers.isEmpty {
            numbers = Array(min ... max)
        }
        var temp: [Int] = []
        for _ in 0...count {
            let index = Int(arc4random_uniform(UInt32(numbers.count)))
            temp.append(numbers.remove(at: index))
        }
        return temp
    }
    
    func showProgress(){
        DispatchQueue.main.async {
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.hud?.bringSubviewToFront(self.view)
            self.hud?.mode = MBProgressHUDMode.indeterminate
            self.hud?.label.text = "Đang tải"
            self.hud?.removeFromSuperViewOnHide = true
        }
    }
    func hideProgress(){
        if self.hud != nil {
            self.hud?.hide(animated: true)
        }
    }
    func showMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
extension BaseViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField = nil
    }
}
