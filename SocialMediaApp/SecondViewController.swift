//
//  SecondViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 30/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func postButtonPressed(sender: AnyObject) {
        
        if inputTextField.text != ""{
            var object = PFObject(className: "Posts")
            object.addObject(kCurrentUser.username, forKey: "username")
            object.addObject(true, forKey: "text")
 //           object.addObject(nil, forKey: "image")
            object.addObject(0, forKey: "Likes")
            object.addObject((kCurrentUser.objectForKey("profilePicture")[0]), forKey: "profilePicture")
            object.addObject(inputTextField.text, forKey: "message")
            
            object.save()
            Global.showAlert("Saved", message: "the post has been published", view: self)
            
       }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

