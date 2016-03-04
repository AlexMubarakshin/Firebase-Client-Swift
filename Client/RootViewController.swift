//
//  ViewController.swift
//  Client
//
//  Created by Alexandr on 03.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
//        if (!isUserLoggedIn){
//            self.performSegueWithIdentifier("loginViewSegue", sender: self)
//            print("Opened login page")
//        } else {
//            self.performSegueWithIdentifier("myProfileViewSegue", sender: self)
//            print("Opened main page")
//        }
//    }
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("myProfileViewSegue", sender: self)
        } else {
            self.performSegueWithIdentifier("loginViewSegue", sender: self)
            print("Opened login page")
        }
    }

}

