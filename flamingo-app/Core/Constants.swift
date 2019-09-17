//
//  Constants.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation

struct Constants {
  // Sample env management
  #if STAGING
  static let apiBaseUrl = URL(string: "http://mobile.flamingogroup.com.vn:6789/")! // swiftlint:disable:this all
  #else
    static let apiBaseUrl = URL(string: "http://mobile.flamingogroup.com.vn:6789/")! // swiftlint:disable:this all
  #endif
}

let K_CURRENT_USER = "CURRENT_USER"
let K_CURRENT_USER_INFO = "CURRENT_USER_INFO"
let K_GrantType = "grant_type"
let K_Username = "username"
let K_Password = "password"
let K_UsernameClient = "usernameClient"
let K_PasswordClient = "passwordClient"
let K_Token = "Token"
let K_AccessToken = "access_token"
