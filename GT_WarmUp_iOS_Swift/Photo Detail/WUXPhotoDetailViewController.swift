//
//  WUXPhotoDetailViewController.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 2/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import UIKit

class WUXPhotoDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photoUrlString:String? {
        didSet {
            if self.imageView != nil {
                displayImage()
            }
        }
    }
    
    var currentPhoto:WUXPhoto? {
        didSet {
            if self.currentPhoto != nil {
                self.photoUrlString = self.currentPhoto!.photoUrlString
            }

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayImage()
    }
    
    func displayImage() {
        
        let qos = Int(QOS_CLASS_USER_INITIATED.value)
        
        if let urlString = self.photoUrlString {
            if let photoUrl = NSURL(string: urlString) {
                
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
    }
    
    //MARK: -
    //MARK: UIScrollViewDelegate
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
