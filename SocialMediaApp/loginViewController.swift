//
//  loginViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 31/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit
import Foundation


class loginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func goButtonPressed(sender: AnyObject) {
        
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            Global.showAlert("error", message: "please enter both a username and a passsword", view: self)
        }else{
            
            PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text, block: { (user:PFUser!, error:NSError!) -> Void in
                
                if user != nil {
                    
                    println("login successful")
                    kCurrentUser = user
                    
                    
                    //segue to transition to main views
                    self.performSegueWithIdentifier("loginToTabBarSegue", sender: nil)
                    
                    
                }else{
                    
                    Global.showAlert("failed", message: "login failed, make sure username and password are correct", view: self)
                    
                }
                
                
            })
                
            
            
            
        }
        
        
    }
}
