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
    
    var selectedIndexPathRow:Int?
    
    //MARK: -
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let favPhoto = WUXFavouriteManager.favouriteList() {
            self.favPhoto = favPhoto
        }
    }
    
    //MARK: -
    //MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favPhoto.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.Storyboard.FavouriteTableViewCellIdentifier) as! UITableViewCell
        
        var photo:WUXPhoto = favPhoto[indexPath.row]
        cell.textLabel!.text = photo.photoTitle
        
        return cell
    }
    
    //MARK: -
    //MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndexPathRow = indexPath.row
    }
    
    //MARK: -
    //MARK: StoryBoard
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.Storyboard.FavouriteShowDetailSegueIdentifier {
            if let photoDetailViewController = segue.destinationViewController as? WUXPhotoDetailViewController {
                if self.selectedIndexPathRow != nil {
                    photoDetailViewController.currentPhoto = self.favPhoto[self.selectedIndexPathRow!]
                }
            }
        }
    }

}
