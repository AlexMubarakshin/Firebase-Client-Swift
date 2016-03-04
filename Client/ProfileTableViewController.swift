//
//  ProfileTableViewController.swift
//  Client
//
//  Created by Alexandr on 03.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        DataService.dataService.CURRENT_USER_REF.unauth()
        
        // Remove the user's uid from storage.
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "userMail")
        // Head back to Login!
        
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
    }
    
}
