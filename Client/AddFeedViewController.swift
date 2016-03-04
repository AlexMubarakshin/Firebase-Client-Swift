//
//  AddFeedViewController.swift
//  Client
//
//  Created by Alexandr on 04.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit
import Firebase

class AddFeedViewController: UIViewController {

    
    @IBOutlet weak var feedField: UITextField!
    var currentUsername = NSUserDefaults.standardUserDefaults().valueForKey("userMail")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Get username of the current user, and set it to currentUsername, so we can add it to the Joke.
//        
//        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
//            let temp = snapshot.value
//            print("temp:\(temp)")
//            let currentUser = snapshot.value.objectForKey("email") as! String
//            
//            print("Usermail: \(currentUser)")
//            self.currentUsername = currentUser
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func saveJoke(sender: AnyObject) {
        let feedText = feedField.text
        if feedText != "" {
            
            // Build the new Joke.
            // AnyObject is needed because of the votes of type Int.
            
            let newFeed: Dictionary<String, AnyObject> = [
                "feedText": feedText!,
                //"votes": 0,
                "author": currentUsername
            ]
            
            // Send it over to DataService to seal the deal.
            
            DataService.dataService.createNewFeed(newFeed)
            
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }
        }

    }


}
