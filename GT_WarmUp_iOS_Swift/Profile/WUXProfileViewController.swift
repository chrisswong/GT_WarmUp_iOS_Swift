//
//  WUXProfileViewController.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 1/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import UIKit

class WUXProfileViewController: WUXBaseViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var snsNoLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    var currentProfile:WUXProfile? = nil {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.spinner?.startAnimating()
        WUXApiManager.retrieveProfile { (error, response) -> (Void) in
            
//            self.spinner?.stopAnimating()
            if error == nil {
                if let profile = response as? WUXProfile {
                    self.currentProfile = profile
                }
            } else {
                
                var alert = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                var alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (alertAction) -> Void in
                    
                })
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.profileImageView.layer.masksToBounds = true
    }
    
    func updateUI() {
        
        if self.currentProfile != nil {
            
            self.userNameLabel.text = self.currentProfile?.userName
            self.passwordLabel.text = self.currentProfile?.password
            self.emailLabel.text    = self.currentProfile?.email
            self.phoneNoLabel.text  = self.currentProfile?.phoneNo
            self.snsNoLabel.text    = self.currentProfile?.snsNo
            
            //let's do it in native way.
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            
            if let imageUrlString = self.currentProfile?.pictureUrlString {
                if let imageUrl = NSURL(string: imageUrlString) {
                    dispatch_async(dispatch_get_global_queue(qos, 0)) {
                        
                        let imageData = NSData(contentsOfURL: imageUrl)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            if imageData != nil {
                                self.profileImageView.image = UIImage(data: imageData!)
                            } else {
                                self.profileImageView.image = nil;
                            }
                        }
                    }
                }
            }
        }
    }
    
}
