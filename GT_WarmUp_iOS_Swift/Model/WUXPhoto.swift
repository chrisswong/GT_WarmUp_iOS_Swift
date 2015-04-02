//
//  WUXPhoto.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 1/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import Foundation

//class WUXPhoto {
//    
//    var albumId:Int                     = 0
//    var photoId:Int                     = 0
//    var photoTitle:String               = ""
//    var photoUrlString:String           = ""
//    var photoThumbnailUrlString:String  = ""
//    var isFavourite:Bool                = false
//    
//}

class WUXPhoto {
    
    let albumId:Int                     = 0
    let photoId:Int                     = 0
    let photoTitle:String               = ""
    let photoUrlString:String           = ""
    let photoThumbnailUrlString:String  = ""
    let isFavourite:Bool                = false
    
    init?(resultDict: [String: AnyObject])
    {
        if let photoAlbumId = resultDict["albumId"] as? Int {
            self.albumId = photoAlbumId
        }
        else {
            return nil
        }
        
        if let photoId = resultDict["id"] as? Int {
            self.photoId = photoId
        }
        else {
            return nil
        }
        
        if let photoTitle = resultDict["title"] as? String {
            self.photoTitle = photoTitle
        }
        
        if let photoUrlString = resultDict["url"] as? String {
            self.photoUrlString = photoUrlString
        }
        else {
            return nil
        }
        
        if let photoThumbnailString = resultDict["thumbnailUrl"] as? String {
            self.photoThumbnailUrlString = photoThumbnailString
        }
    }
}