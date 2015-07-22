//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

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
        static let PageSizeKey = "_count="
    }
    
    struct Persistent {
        static let favouriteListUserDefaultKey = "com.gtomato.enterprise.ios.GT-Warm-UP.favouriteList"
    }
    
    class func albumPath(startIndex: Int, pageSize: Int) -> String {
        return Constants.APIPath.AlbumPrefix + Constants.APIPath.StartIndexKey  + String(startIndex) + "&" + Constants.APIPath.PageSizeKey + String(pageSize)
    }
}

print(Constants.albumPath(0, pageSize: 20))
