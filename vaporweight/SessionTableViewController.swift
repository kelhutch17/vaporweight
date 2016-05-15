//
//  SessionTableViewController.swift
//  vaporweight
//
//  Created by Kelly Hutchison on 5/15/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import UIKit

class SessionTableViewController : UITableViewController {
    
    let model = Model.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload", name: model.locationsUpdatedKey(), object: nil)
        
    }
    
    func reload (notification: NSNotification) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.locations.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("sessionCell", forIndexPath: indexPath) as! SessionTableViewCell
        
        let locations = model.locations
        
        cell.durationLabel.text = locations[index].session.duration?.description
        cell.cityLabel.text = locations[index].title
        cell.dateLabel.text =  locations[index].session.startTime.timeIntervalSince1970.description
        
        return cell;
    }
}
