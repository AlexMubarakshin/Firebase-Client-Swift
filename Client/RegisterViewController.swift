//
//  RegisterViewController.swift
//  Client
//
//  Created by Alexandr on 03.03.16.
//  Copyright © 2016 Alexandr. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswTextField: UITextField!
    @IBOutlet weak var rPswTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButtonTappes(sender: AnyObject) {
        let email = emailTextField.text!;
        let password = pswTextField.text!;
        let rPassword = rPswTextField.text!;
        
        if(email.isEmpty || password.isEmpty || rPassword.isEmpty) {
            displayAlertMessage("Заполните все поля!", myTitle: "Ошибка")
            print("Empty")
            return
        }
        
        if(password != rPassword) {
            displayAlertMessage("Пароли не совпадают", myTitle: "Ошибка")
            print("Passwords do not match")
            return
        }
//        
//        let myURL = NSURL(string: "http://localhost:3001/register")
//        let request = NSMutableURLRequest(URL:myURL!)
//        request.HTTPMethod = "POST"
//        
//        let postString = "email=\(email)&pass=\(password)"
//        
//        
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
//        
//        
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if error != nil {
//                print("Error")
//                self.dismissViewControllerAnimated(true, completion: nil)
//                return
//            }
//            
//            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)!
//            print(responseString)
//            
//        }
//        
//        task.resume();
        
        DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
            
            if error != nil {
                
                // There was a problem.
                self.displayAlertMessage("Проверьте соединение", myTitle: "Ошибка")
                
            } else {
                // Create and Login the New User with authUser
                DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
                    err, authData in
                    
                    let user = ["provider": authData.provider!, "email": email]
                    
                    // Seal the deal in DataService.swift.
                    DataService.dataService.createNewAccount(authData.uid, user: user)
                })
                
                // Store the uid for future access - handy!
                NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
                
                // Enter the app.
                
                let protectedPage = self.storyboard!.instantiateViewControllerWithIdentifier("protectedView")
                UIApplication.sharedApplication().keyWindow?.rootViewController = protectedPage
            }
        })
    }
    
    
    
    func displayAlertMessage (message: String, myTitle: String) {
        let alert = UIAlertController(title: myTitle, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ок", style: .Default, handler: nil)
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
     }
    

}
