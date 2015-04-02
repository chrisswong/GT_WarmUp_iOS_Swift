//
//  WUXAlbumCollectionViewCell.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 2/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import UIKit

class WUXAlbumCollectionViewCell: UICollectionViewCell {
    
    typealias AddButtonActionHandler = (sender: WUXAlbumCollectionViewCell) -> (Void)
    
    var handler:AddButtonActionHandler?
    @IBOutlet weak var imageView: UIImageView!
    
    var photoUrlString:String = ""
    
    func configureCell(photo : WUXPhoto, addButtonActionHandler: AddButtonActionHandler ) {
        
        self.photoUrlString = photo.photoUrlString
        self.handler = addButtonActionHandler
        
        let qos = Int(QOS_CLASS_USER_INITIATED.value)
        
        if let photoUrl = NSURL(string: self.photoUrlString) {
            
            dispatch_async(dispatch_get_global_queue(qos, 0)) {
                
                let imageData = NSData(contentsOfURL: photoUrl)
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if imageData != nil {
                        self.imageView.image = UIImage(data: imageData!)
                    } else {
                        self.imageView.image = nil
                    }
                }
            }
        }
    }
    
    @IBAction func addButtonDidTap(sender: UIButton) {
        if self.handler != nil {
            self.handler!(sender: self)
        }
    }
    
    

}
