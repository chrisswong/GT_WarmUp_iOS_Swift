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
    
    typealias WUXAPICallback = (NSError?, AnyObject?) -> (Void)
    
    typealias WUXAPIPhotoListCallBack = (NSError?, [WUXPhoto]?) -> (Void)
    
    typealias PropertyList = AnyObject
    
    class func retrieveProfile(callback: WUXAPICallback) {
        
        Alamofire.request(.GET, Constants.APIPath.Profile)
            .response { (request, response, data, error) in
                var propertyListResponse: PropertyList?

                if data != nil {
                    propertyListResponse = NSJSONSerialization.JSONObjectWithData(
                        data as! NSData,
                        options: NSJSONReadingOptions.MutableLeaves,
                        error: nil
                    )
                    
                    if propertyListResponse != nil {
                        if let dictionary = propertyListResponse as? NSDictionary {
                            if let profileList = dictionary["results"] as? NSArray {
                                if let profileDict = profileList[0] as? NSDictionary {
                                    if let userDict = profileDict["user"] as? NSDictionary {
                                        var profile:WUXProfile = WUXProfile()
                                        
                                        if let userEmail = userDict["email"] as? String {
                                            profile.email = userEmail
                                        }
                                        
                                        if let userName = userDict["username"] as? String {
                                            profile.userName = userName
                                        }
                                        
                                        if let userPassword = userDict["password"] as? String {
                                            profile.password = userPassword
                                        }
                                        
                                        if let userPhoneNo = userDict["phone"] as? String {
                                            profile.phoneNo = userPhoneNo
                                        }
                                        
                                        if let userSnsNo = userDict["NINO"] as? String {
                                            profile.snsNo = userSnsNo
                                        }
                                        
                                        if let profilePicDict = userDict["picture"] as? NSDictionary {
                                            
                                            if let profileThumbnailUrlString = profilePicDict["thumbnail"] as? String {
                                                profile.pictureUrlString = profileThumbnailUrlString
                                            }
                                        }
                                        
                                        callback(nil , profile)
                                    }
                                }
                            }
                        }
                    } else {
                        
                        callback( self.error(999, description: "JSON could not parse.") , nil)
                    }
                    
                } else {
                    callback( self.error(998, description: "Empty JSON Response")  , nil)
                }
        }
    }
    
    class func retrievePhoto(startIndex: Int, pageSize: Int,  callback: WUXAPIPhotoListCallBack) {
        
        if (startIndex < 0 ) {
            callback( self.error(997, description: "startIndex can not be negative") , nil)
            return
        }
        
        if (pageSize < 0 ){
            callback( self.error(996, description: "pageSize can not be negative") , nil)
            return
        }
        
        var path: String = Constants.albumPath(startIndex, pageSize: pageSize)
        Alamofire.request(.GET, path )
            .response { (request, response, data, error) in
                var propertyListResponse: PropertyList?
                
                if let aData = data as? NSData
                {
                    if let aPropertyListResponse = NSJSONSerialization.JSONObjectWithData(aData, options: .allZeros, error: nil) as? [[String: AnyObject]]
                    {
                        var photos = [WUXPhoto]()
                        for i in 0..<aPropertyListResponse.count {
                            var dict = aPropertyListResponse[i]
                            if let photo = WUXPhoto(resultDict: dict) {
                                photos.append(photo)
                            }
                        }
                        
                        callback(nil, photos)
                        
                    } else {
                        
                        callback( self.error(999, description: "JSON could not parse.") , nil)
                    }
                } else {
                    
                    callback( self.error(998, description: "Empty JSON Response")  , nil)
                
                }
        }
        
    }
    
    private func log(whatToLog: AnyObject) {
        debugPrintln("TwitterRequest: \(whatToLog)")
    }
    
    private class func error(errorCode :Int , description: String) -> NSError {
        var errorDict = [NSLocalizedDescriptionKey: description]
        let bundleId = NSBundle.mainBundle().infoDictionary?["CFBundleIdentifier"] as! String
        return NSError(domain: bundleId, code: errorCode , userInfo: errorDict)
    }
}


