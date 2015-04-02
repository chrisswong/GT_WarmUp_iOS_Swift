//
//  WUXAlbumCollectionViewController.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 2/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import UIKit

class WUXAlbumCollectionViewController: UICollectionViewController {

    var photoList:[WUXPhoto]? = nil
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func fetchPhotos() {
        
        WUXApiManager.retrievePhoto { (error, response) -> (Void) in
            
            if error == nil {
                
                
            }
            
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier(Constants.Storyboard.AlbumCollectionViewCellIdentifier, forIndexPath: indexPath) as WUXAlbumCollectionViewCell
        
        if self.photoList != nil {
            var list:[WUXPhoto] = self.photoList!
            let photo = list[0]
            cell.configureCell(photo, addButtonActionHandler: { (sender) -> (Void) in
                var indexPath:NSIndexPath = collectionView.indexPathForCell(sender)!
                
            })
        }
        
        return cell
        
    }
    
    func handleFavourite(index: Int) {
        if self.photoList != nil {
            var list:[WUXPhoto] = self.photoList!
            let photo = list[index]
            
            if photo.isFavourite {
                 WUXFavouriteManager.removeFavourite(photo)
            }
            else {
                 WUXFavouriteManager.addFavourite(photo)
            }
        }
    }
}
