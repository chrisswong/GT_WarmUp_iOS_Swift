//
//  WUXApiManager.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 1/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import Foundation
import Alamofire

class WUXApiManager {
    
    typealias ProfileCallback = (NSError?, AnyObject?) -> (Void)
    class func retrieveProfile(callback: ProfileCallback) {
        
        Alamofire.request(.GET, "http://api.randomuser.me/")
            .response { (request, response, data, error) in
                
        }
    }
}
