//
//  CreateAccountViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 31/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func goButtonPressed(sender: AnyObject) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" || emailTextField.text == "" {
            Global.showAlert("error", message: "Username, password and email are required", view: self)
        } else{
            
            //create pfUser
            
            
            var user = PFUser()
            user.password = passwordTextField.text
            user.username = usernameTextField.text
            user.email = emailTextField.text
            
            user.addObject("sam", forKey: "friends")
            
            var imageData = UIImagePNGRepresentation(UIImage(named: "headImage.png")) as NSData
            let imageFile :PFFile = PFFile(data: imageData)
            
            user.addObject(imageFile, forKey: "profilePicture")
            
            user.signUpInBackgroundWithBlock { (succeeded: Bool!, error: NSError!) -> Void in
                
                if error != nil{
                    let errorString = error.userInfo?["error"] as? NSString
                    
                    Global.showAlert("error", message: "\(errorString)", view:self)
                    
                }
                else{
                    
                    
                    println("Login successful")
                    self.performSegueWithIdentifier("signUpToSignInSegue", sender: nil)
                    println("seguedone")
                    
                    //Global.showAlert("Account Created", message: "Please sign in", view:self)
                    
                    
                }
                
            }
            
            
            
            
        }
        
    }
}
