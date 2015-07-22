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
    
    var collectionViewSelectedIndexPath:NSIndexPath?
    
    var photoList:[WUXPhoto] = [WUXPhoto]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var startIndex: Int = 0
    var pageSize: Int = 20
    
    //MARK: -
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchPhotos()
    }
    
    //MARK: -
    //MARK: CollectionView 
    
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.collectionViewSelectedIndexPath = indexPath
        self.performSegueWithIdentifier(Constants.Storyboard.AlbumShowDetailSegueIdentifier , sender: nil)
    }
    
    //MARK: -
    //MARK: Storyboard
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.Storyboard.AlbumShowDetailSegueIdentifier {
            if let photoDetailViewController = segue.destinationViewController as? WUXPhotoDetailViewController {
                if self.collectionViewSelectedIndexPath != nil {
                    let selectedPhoto = self.photoList[self.collectionViewSelectedIndexPath!.row]
                    photoDetailViewController.currentPhoto = selectedPhoto
                }
            }
        }

    }
    
    //MARK: -
    //MARK: Helper Methods
    
    func fetchPhotos() {
        
        WUXApiManager.retrievePhoto(startIndex, pageSize: self.pageSize)
            { (error, response) -> (Void) in
            
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
