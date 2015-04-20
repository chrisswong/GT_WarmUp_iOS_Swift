//
//  WUXFavouriteTableViewController.swift
//  GT_WarmUp_iOS_Swift
//
//  Created by Chris on 2/4/15.
//  Copyright (c) 2015 Green Tomato. All rights reserved.
//

import UIKit

class WUXFavouriteTableViewController: UITableViewController {
    
    var favPhoto:[WUXPhoto] = [WUXPhoto]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let favPhoto = WUXFavouriteManager.favouriteList() {
            self.favPhoto = favPhoto
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favPhoto.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.Storyboard.FavouriteTableViewCellIdentifier) as! UITableViewCell
        
        var photo:WUXPhoto = favPhoto[indexPath.row]
        println("photo id = \(photo.photoId)")
        cell.textLabel!.text = photo.photoTitle
        
        return cell
    }

}
