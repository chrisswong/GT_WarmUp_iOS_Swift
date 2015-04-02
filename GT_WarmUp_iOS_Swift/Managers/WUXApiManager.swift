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
    
    typealias PropertyList = AnyObject
    
    class func retrieveProfile(callback: WUXAPICallback) {
        
        Alamofire.request(.GET, Constants.APIPath.Profile)
            .response { (request, response, data, error) in
                var propertyListResponse: PropertyList?

                if data != nil {
                    propertyListResponse = NSJSONSerialization.JSONObjectWithData(
                        data as NSData,
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
                        
                        var errorDict = [NSLocalizedDescriptionKey:"JSON could not parse."]
                        var jsonCouldNotParseError = NSError(domain: "com.gtomato.enterprise.ios.GT-Warm-UP", code: 999, userInfo: errorDict)
                        callback(jsonCouldNotParseError , nil)
                    }
                    
                } else {
                    
                    var errorDict = [NSLocalizedDescriptionKey:"Empty JSON Response"]
                    var jsonCouldNotParseError = NSError(domain: "com.gtomato.enterprise.ios.GT-Warm-UP", code: 998, userInfo: errorDict)
                    callback(jsonCouldNotParseError , nil)
                }
        }
    }
    
    class func retrievePhoto(callback: WUXAPICallback) {
        
        Alamofire.request(.GET, Constants.APIPath.Album)
            .response { (request, response, data, error) in
                var propertyListResponse: PropertyList?
                
                if data != nil {
                    
                    propertyListResponse = NSJSONSerialization.JSONObjectWithData(
                        data as NSData,
                        options: NSJSONReadingOptions.MutableLeaves,
                        error: nil
                    )
                    //Currently handle one photo only
                    if propertyListResponse != nil {
                        
                        if let photoDict = propertyListResponse as? NSDictionary {
                            
                            var photo:WUXPhoto = WUXPhoto()
                            if let photoAlbumId = photoDict["albumId"] as? Int {
                                photo.albumId = photoAlbumId
                            }
                            
                            if let photoId = photoDict["id"] as? Int {
                                photo.photoId = photoId
                            }
                            
                            if let photoTitle = photoDict["title"] as? String {
                                photo.photoTitle = photoTitle
                            }
                            
                            if let photoUrlString = photoDict["url"] as? String {
                                photo.photoUrlString = photoUrlString
                            }
                            
                            if let photoThumbnailString = photoDict["thumbnailUrl"] as? String {
                                photo.photoThumbnailUrlString = photoThumbnailString
                            }
                            
                            callback(nil,[photo])
                        }
                        
                    } else {
                        var errorDict = [NSLocalizedDescriptionKey:"JSON could not parse."]
                        var jsonCouldNotParseError = NSError(domain: "com.gtomato.enterprise.ios.GT-Warm-UP", code: 999, userInfo: errorDict)
                        callback(jsonCouldNotParseError , nil)
                    }
                    
                    
                } else {
                    var errorDict = [NSLocalizedDescriptionKey:"Empty JSON Response"]
                    var jsonCouldNotParseError = NSError(domain: "com.gtomato.enterprise.ios.GT-Warm-UP", code: 998, userInfo: errorDict)
                    callback(jsonCouldNotParseError , nil)
                }
        }
        
    }
    
    private func log(whatToLog: AnyObject) {
        debugPrintln("TwitterRequest: \(whatToLog)")
    }
}


