//
//  App.swift
//  Stindy
//
//  Created by Nguyễn Chí Thành on 6/20/18.
//  Copyright © 2018 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

@objc class App: NSObject {
    @objc static let shared = App()
    var appDelegate: AppDelegate!
    let appName = "Flamingo"
    let defaults: UserDefaults = UserDefaults.standard
    var deviceToken = ""
    
    private override init() {
        super.init()
        self.appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    }
    
    func save(value: AnyObject, forKey: String){
        self.defaults.set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: forKey)
        self.defaults.synchronize()
    }
    
    func getString(key: String) -> String{
        let data = self.defaults.value(forKey: key)
        if data != nil {
            let str = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            if str != nil {
                return str as? String ?? ""
            }
        }
        return ""
    }
    
    func getStringAnyObject(key: String) -> [String : AnyObject]{
        let data = self.defaults.value(forKey: key)
        if data != nil {
            let anyObject = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            if anyObject != nil {
                return anyObject as? [String : AnyObject] ?? [:]
            }
        }
        return [:]
    }
    
    func remove(key: String) {
        self.defaults.removeObject(forKey: key)
        self.defaults.synchronize()
    }
}
