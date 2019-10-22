//
//  Extensions.swift
//  flamingo-app
//
//  Created by Trương Trung Kiên on 9/24/19.
//  Copyright © 2019 Trương Trung Kiên. All rights reserved.
//

import Foundation


extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
