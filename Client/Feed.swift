//
//  Feed.swift
//  Client
//
//  Created by Alexandr on 04.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import Foundation
import Firebase

class Feed {
    private var _feedRef: Firebase!
    
    private var _feedKey: String!
    private var _feedText: String!
    //private var _feedVotes: Int!
    private var _username: String!
    
    var feedKey: String {
        return _feedKey
    }
    
    var feedText: String {
        return _feedText
    }
    
//    var feedVotes: Int {
//        return _feedVotes
//    }
    
    var username: String {
        return _username
    }
    
    // Initialize the new Feed
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._feedKey = key
        
        // Within the Feed, or Key, the following properties are children
        
//        if let votes = dictionary["votes"] as? Int {
//            self._feedVotes = votes
//        }
        
        if let feed = dictionary["feedText"] as? String {
            self._feedText = feed
        }
        
        if let user = dictionary["author"] as? String {
            self._username = user
        } else {
            self._username = ""
        }
        
        // The above properties are assigned to their key.
        
        self._feedRef = DataService.dataService.FEED_REF.childByAppendingPath(self._feedKey)
    }
    
//    func addSubtractVote(addVote: Bool) {
//        
//        if addVote {
//            _feedVotes = _feedVotes + 1
//        } else {
//            _feedVotes = _feedVotes - 1
//        }
//        
//        // Save the new vote total.
//        
//        //_feedRef.childByAppendingPath("votes").setValue(_feedVotes)
//     }
    }

