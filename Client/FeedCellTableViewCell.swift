//
//  FeedCellTableViewCell.swift
//  Client
//
//  Created by Alexandr on 04.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit
import Firebase

class FeedCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedText: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    //@IBOutlet weak var totalVotesLabel: UILabel!
    //@IBOutlet weak var thumbVoteImage: UIImageView!
    
    var feed: Feed!
    var voteRef: Firebase!
    
    func configureCell(feed: Feed) {
        self.feed = feed
        
        // Set the labels and textView.
        
        self.feedText.text = feed.feedText
        //self.totalVotesLabel.text = "Total Votes: \(feed.feedVotes)"
        self.usernameLabel.text = feed.username
        
        // Set "votes" as a child of the current user in Firebase and save the feed key in votes as a boolean.
        
        voteRef = DataService.dataService.CURRENT_USER_REF.childByAppendingPath("votes").childByAppendingPath(feed.feedKey)
        
        // observeSingleEventOfType() listens for the thumb to be tapped, by any user, on any device.
        
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            // Set the thumb image.
            
//            if let thumbsUpDown = snapshot.value as? NSNull {
//                
//                // Current user hasn't voted for the feed... yet.
//                
//                print(thumbsUpDown)
//                self.thumbVoteImage.image = UIImage(named: "thumb-down")
//            } else {
//                
//                // Current user voted for the feed!
//                
//                self.thumbVoteImage.image = UIImage(named: "thumb-up")
//            }
        })
    }
    
//    func voteTapped(sender: UITapGestureRecognizer) {
//        
//        // observeSingleEventOfType listens for a tap by the current user.
//        
//        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
//            
//            if let thumbsUpDown = snapshot.value as? NSNull {
//                print(thumbsUpDown)
//                self.thumbVoteImage.image = UIImage(named: "thumb-down")
//                
//                // addSubtractVote(), in Feed.swift, handles the vote.
//                
//                self.feed.addSubtractVote(true)
//                
//                // setValue saves the vote as true for the current user.
//                // voteRef is a reference to the user's "votes" path.
//                
//                self.voteRef.setValue(true)
//            } else {
//                self.thumbVoteImage.image = UIImage(named: "thumb-up")
//                self.feed.addSubtractVote(false)
//                self.voteRef.removeValue()
//            }
//            
//        })
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UITapGestureRecognizer is set programatically.
        
        //let tap = UITapGestureRecognizer(target: self, action: "voteTapped:")
        //tap.numberOfTapsRequired = 1
        //thumbVoteImage.addGestureRecognizer(tap)
        //thumbVoteImage.userInteractionEnabled = true
    }
    
}
