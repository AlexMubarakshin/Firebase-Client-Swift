//
//  LoginViewController.swift
//  Client
//
//  Created by Alexandr on 03.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterButtonTapped(sender: AnyObject) {
        print("start login")
        let email = emailTextField.text!
        let password = pswTextField.text!
        
        if(email.isEmpty || password.isEmpty){
            displayAlertMessage("Заполните все поля!", myTitle: "Ошибка")
            print("Empty")
            return
        }
        // Login with the Firebase's authUser method
        
        DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
            
            if error != nil {
                print(error)
                self.displayAlertMessage("Ошибка", myTitle: "Что-то пошло не так")
            } else {
                // Be sure the correct uid is stored.
                
                NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                NSUserDefaults.standardUserDefaults().setValue(email, forKey: "userMail")
                
                // Enter the app!
                
                //self.dismissViewControllerAnimated(true, completion: nil)
                self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
            }
        })
    }
        
//        let myURL = NSURL(string: "http://localhost:3001/login")
//        let request = NSMutableURLRequest(URL:myURL!)
//        request.HTTPMethod = "POST"
//        
//        let postString = "email=\(email)&pass=\(password)"
//        
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
//        
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if error != nil {
//                print("Error")
//                return
//            }
//            
//            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)!
//            print(responseString)
//            if responseString == "true" {
//                print("Login in")
//                NSUserDefaults.standardUserDefaults().setObject(email, forKey: "userMail")
//                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
//                NSUserDefaults.standardUserDefaults().synchronize()
//                self.getInfo(email)
//                self.dismissViewControllerAnimated(true, completion: nil)
//            } else {
//                print("Incorrect login or password")
//            }
//        }
//        task.resume();
        
        
    
//    func getInfo(email: String) {
//        let myURL = NSURL(string: "http://localhost:3001/getInfo")
//        let request = NSMutableURLRequest(URL:myURL!)
//        request.HTTPMethod = "POST"
//        
//        let postString = "profileLogin=\(email)"
//        
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
//        
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if error != nil {
//                print("Error")
//                return
//            }
//            
//            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)!
//            print(responseString)
//            let dictionary = self.JSONParseDictionary(responseString)
//            NSUserDefaults.standardUserDefaults().setObject(dictionary["fName"] as! String, forKey: "fName")
//            NSUserDefaults.standardUserDefaults().setObject(dictionary["sName"] as! String, forKey: "sName")
//            NSUserDefaults.standardUserDefaults().setObject(dictionary["mNumber"] as! String, forKey: "mNumber")
//        }
//        task.resume();
//    }
//    
//    func JSONParseDictionary(string: String) -> [String: AnyObject]{
//        
//        if let data = string.dataUsingEncoding(NSUTF8StringEncoding){
//            
//            do{
//                if let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject]{
//                    return dictionary
//                }
//            } catch {
//                print("error")
//            }
//        }
//        return [String: AnyObject]()
//    }
//    
    func displayAlertMessage (message: String, myTitle: String) {
        let alert = UIAlertController(title: myTitle, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ок", style: .Default, handler: nil)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
