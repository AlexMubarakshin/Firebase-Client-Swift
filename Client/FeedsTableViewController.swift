//
//  FeedsTableViewController.swift
//  Client
//
//  Created by Alexandr on 04.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit
import Firebase

class FeedsTableViewController: UITableViewController {

    var feeds = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observeEventType is called whenever anything changes in the Firebase - new Feeds or Votes.
        // It's also called here in viewDidLoad().
        // It's always listening.
        
        DataService.dataService.FEED_REF.observeEventType(.Value, withBlock: { snapshot in
            
            // The snapshot is a current look at our feeds data.
            
            print("snap: \(snapshot.value)")
            
            self.feeds = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our feeds array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let feed = Feed(key: key, dictionary: postDictionary)
                        
                        // Items are returned chronologically, but it's more fun with the newest feeds first.
                        
                        self.feeds.insert(feed, atIndex: 0)
                    }
                }
                
            }
            
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData()
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feeds.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let feed = feeds[indexPath.row]
        
        // We are using a custom cell.
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("FeedCellTableViewCell") as? FeedCellTableViewCell {
            
            // Send the single feed to configureCell() in FeedCellTableViewCell.
            
            cell.configureCell(feed)
            
            return cell
            
        } else {
            
            return FeedCellTableViewCell()
            
        }
        
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
          self.dismissViewControllerAnimated(true, completion: nil)
    }
}
