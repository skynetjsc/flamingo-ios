//
//  BaseServiceCaller.swift
//  Lucky Max
//
//  Created by Nguyễn Chí Thành on 7/28/19.
//  Copyright © 2019 Nguyễn Chí Thành. All rights reserved.
//

import UIKit

class BaseService: NSObject {
    static let shared = BaseService()
    
    func getToken(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/Token", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func login(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/Login", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    
    func loginFB(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/LoginFacebook", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func loginGG(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/LoginGoogle", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func register(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/Register", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func forgotPassword(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/ChangePassword", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func changePassword(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/ChangePassword", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    
    func verifyCode(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/VerifyCode", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    
    
    // Book Room PropertyID
    func searchRoom(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Property/Search", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func searchRoomWidthPropertyID(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/GetList", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func listFavorite(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/Favourite", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func addFavorite(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/AddFavourite", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func listRoomLastWatch(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/SeenList", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    
    func detailRoom(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/Detail", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func ratingRoom(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/Rate", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func infoRoom(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Booking/Detail", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func bookRoom(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Booking/Booking", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    
    func cancelRoom(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Booking/Cancel", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func historyRoom(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Booking/History", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func homeInfo(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Property/Home", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func homeRoom(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/GetList", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func listCountry(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/GetListCountry", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func updatePaymentInfo(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/CreditCard/Insert", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func listBookHistory(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Booking/History", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func bookDetail(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Booking/Detail", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func listPromotion(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Promotion/List", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func listNews(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/New/List", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func getUserInfo(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/GetInfor", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func getSeenList(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/SeenList", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func vipCardInfo(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/VipCard/GetInfo", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func updateUserInfo(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/UserLogin/UpdateProfile", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }
    
    func geListRate(params: [String : AnyObject], callback: @escaping (_ status: Bool, _ response: [String: AnyObject])->()){
        Service.shared().post(params, withURL: BASE_URL + "/api/Room/GetListRate", success: { (data, response) in
            callback(true, response as? [String : AnyObject] ?? [:])
        }, failure: { (task, error) in
            callback(false, [:])
        })
    }

    
}


