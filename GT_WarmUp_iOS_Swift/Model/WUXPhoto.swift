//
//  WUXPhoto.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 1/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import Foundation

class WUXPhoto:NSObject, NSCoding {
    
    var albumId:Int                     = 0
    var photoId:Int                     = 0
    var photoTitle:String               = ""
    var photoUrlString:String           = ""
    var photoThumbnailUrlString:String  = ""
    var isFavourite:Bool                = false
    
    init?(resultDict: [String: AnyObject])
    {
        super.init()
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
        } else {
            return nil
        }
        
        self.isFavourite = false
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.albumId, forKey: "albumId")
        aCoder.encodeInteger(self.photoId, forKey: "photoId")
        aCoder.encodeObject(self.photoTitle, forKey: "photoTitle")
        aCoder.encodeObject(self.photoUrlString, forKey: "photoUrlString")
        aCoder.encodeObject(self.photoThumbnailUrlString, forKey: "photoThumbnailUrlString")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.albumId = aDecoder.decodeIntegerForKey("albumId")
        self.photoId = aDecoder.decodeIntegerForKey("photoId")
        self.photoTitle = aDecoder.decodeObjectForKey("photoTitle") as! String
        self.photoUrlString = aDecoder.decodeObjectForKey("photoUrlString") as! String
        self.photoThumbnailUrlString = aDecoder.decodeObjectForKey("photoThumbnailUrlString") as! String
        self.isFavourite = true
    }
}