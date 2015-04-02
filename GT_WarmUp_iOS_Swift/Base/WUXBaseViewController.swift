//
//  WUXBaseViewController.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 2/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import UIKit

class WUXBaseViewController: UIViewController {
    
    var spinner:UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.spinner?.hidesWhenStopped = true
        
        self.view.addSubview(self.spinner!)
        
        self.spinner?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var spinnerHorizontalConstraint = NSLayoutConstraint(item: self.view,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.spinner,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0)
        
        self.view.addConstraint(spinnerHorizontalConstraint)
        
        var spinnerVerticalConstraint = NSLayoutConstraint(item: self.view,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self.spinner,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0.0)
        
        self.view.addConstraint(spinnerVerticalConstraint)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showAlert(message: NSString?) {
        var alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        var alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (alertAction) -> Void in
            
        })
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
