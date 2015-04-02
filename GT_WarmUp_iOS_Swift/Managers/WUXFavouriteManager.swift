//
//  WUXFavouriteManager.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 2/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import Foundation

extension Array {
    func find(includedElement: T -> Bool) -> Int? {
        for (idx, element) in enumerate(self) {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}

class WUXFavouriteManager {
    
    class func addFavourite(photo: WUXPhoto) {
        let standardUserDefault = NSUserDefaults.standardUserDefaults()
        
        var list:[WUXPhoto]? = WUXFavouriteManager.favouriteList()
        
        if list != nil {
            var tempList:[WUXPhoto] = list!
            tempList.append(photo)
            list = tempList
        } else {
            list = [photo]
        }
        WUXFavouriteManager.saveList(list!)
    }
    
    class func removeFavourite(photo: WUXPhoto) {
        let standardUserDefault = NSUserDefaults.standardUserDefaults()
        
        var list:[WUXPhoto]? = WUXFavouriteManager.favouriteList()
        
        if list != nil {
            var tempList:[WUXPhoto] = list!
            
            var index:Int? = tempList.find{ $0.photoId == photo.photoId }
            
            if index != nil {
                tempList.removeAtIndex(index!)
            }
            
            WUXFavouriteManager.saveList(tempList)
        }

        
    }
    
    class func saveList(photoList:[WUXPhoto]) {
        let standardUserDefault = NSUserDefaults.standardUserDefaults()
        standardUserDefault.setObject(NSKeyedArchiver.archivedDataWithRootObject(photoList), forKey: Constants.Persistent.favouriteListUserDefaultKey)
        standardUserDefault.synchronize()

    }
    
    class func favouriteList() -> [WUXPhoto]? {
        let standardUserDefault = NSUserDefaults.standardUserDefaults()
        if let listData = standardUserDefault.objectForKey(Constants.Persistent.favouriteListUserDefaultKey) as? NSData {
            return (NSKeyedUnarchiver.unarchiveObjectWithData(listData) as [WUXPhoto])
        } else {
            return nil
        }
    }
}
