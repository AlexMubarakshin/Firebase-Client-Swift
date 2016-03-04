//
//  DataService.swift
//  Client
//
//  Created by Alexandr on 04.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _FEED_REF = Firebase(url: "\(BASE_URL)/feeds")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    var FEED_REF: Firebase {
        return _FEED_REF
    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
    func createNewFeed(feed: Dictionary<String, AnyObject>) {
        
        // Save the Joke
        // JOKE_REF is the parent of the new Joke: "jokes".
        // childByAutoId() saves the joke and gives it its own ID.
        
        let firebaseNewFeed = FEED_REF.childByAutoId()
        
        // setValue() saves to Firebase.
        
        firebaseNewFeed.setValue(feed)
    }
    
}