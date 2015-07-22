//
//  Constants.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 2/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import Foundation

class Constants {
    struct Storyboard {
        static let AlbumCollectionViewCellIdentifier = "AlbumCollectionViewCellIdentifier"
        static let FavouriteTableViewCellIdentifier = "FavouriteTableViewCellIdentifier"
        static let AlbumShowDetailSegueIdentifier = "AlbumShowDetailSegueIdentifier"
        static let FavouriteShowDetailSegueIdentifier = "FavouriteShowDetailSegueIdentifier"
    }
    
    struct APIPath {
        static let Profile = "http://api.randomuser.me/"
        static let AlbumPrefix = "http://jsonplaceholder.typicode.com/photos?"
        static let StartIndexKey = "_start="
        static let PageSizeKey = "_limit="
    }
    
    struct Persistent {
        static let favouriteListUserDefaultKey = "com.gtomato.enterprise.ios.GT-Warm-UP.favouriteList"
    }
    
    class func albumPath(startIndex: Int, pageSize: Int) -> String {
        return Constants.APIPath.AlbumPrefix + Constants.APIPath.StartIndexKey  + String(startIndex) + "&" + Constants.APIPath.PageSizeKey + String(pageSize)
    }
}
