//
//  WUXAlbumCollectionViewController.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 2/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import UIKit

class WUXAlbumCollectionViewController: WUXBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var photoList:[WUXPhoto] = [WUXPhoto]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchPhotos()
    }
    
    func fetchPhotos() {
        
        WUXApiManager.retrievePhoto { (error, response) -> (Void) in
            
            if error == nil {
                
                if response != nil {
                    
                    self.photoList = response!
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.collectionView.reloadData()
                    }
                }
            } else {
                self.showAlert(error?.localizedDescription)
            }
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier(Constants.Storyboard.AlbumCollectionViewCellIdentifier, forIndexPath: indexPath) as! WUXAlbumCollectionViewCell
        
        let photo = self.photoList[indexPath.row]
        weak var weakSelf = self
        cell.configureCell(photo, addButtonActionHandler: { (sender) -> (Void) in
            var indexPath:NSIndexPath = collectionView.indexPathForCell(sender)!
            weakSelf?.handleFavourite(indexPath.item)
        })
        
        return cell
        
    }
    
    func handleFavourite(index: Int) {
        let photo = self.photoList[index]
        
        if photo.isFavourite {
             WUXFavouriteManager.removeFavourite(photo)
        }
        else {
             WUXFavouriteManager.addFavourite(photo)
        }
    }
}
