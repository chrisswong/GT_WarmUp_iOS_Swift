//
//  WUXProfileViewController.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 1/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import UIKit

class WUXProfileViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        WUXApiManager.retrieveProfile { (error, response) -> (Void) in
            
        }
    }
}
