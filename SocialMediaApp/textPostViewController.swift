//
//  textPostViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 2/02/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class textPostViewController: UIViewController {
    
    
    var object:PFObject!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var fullProfileButton: UIButton!
   
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var otherWhiteView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //shadosws for views
        
        
        let shadowPath = UIBezierPath(rect: whiteView.bounds)
        whiteView.layer.masksToBounds = false
        whiteView.layer.shadowColor = UIColor.blackColor().CGColor
        whiteView.layer.shadowOffset = CGSizeMake(0.5, 0.5)
        whiteView.layer.shadowOpacity = 0.2
        whiteView.layer.shadowPath = shadowPath.CGPath
        
        let shadowPath2 = UIBezierPath(rect: otherWhiteView.bounds)
        otherWhiteView.layer.masksToBounds = false
        otherWhiteView.layer.shadowColor = UIColor.blackColor().CGColor
        otherWhiteView.layer.shadowOffset = CGSizeMake(0.5, 0.5)
        otherWhiteView.layer.shadowOpacity = 0.2
        otherWhiteView.layer.shadowPath = shadowPath2.CGPath
        
        
        
        //assign data
        
        var text = object.objectForKey("message")[0] as String
        textLabel.text = "\"\(text)\""
        
        var data: AnyObject = object.objectForKey("profilePicture")[0]
        data.getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                self.profilePictureImageView.image = UIImage(data:imageData)
            }
        }
        
        profilePictureImageView.layer.borderWidth=3.0
        profilePictureImageView.layer.masksToBounds = false
        profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profilePictureImageView.layer.cornerRadius = 13
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.height/2
        profilePictureImageView.clipsToBounds = true
        
        var username = object.objectForKey("username")[0] as String
        fullProfileButton.setTitle("View \(username)'s full profile", forState: UIControlState.Normal)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var backButtonPressed: UIBarButtonItem!

    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    @IBAction func viewFullProfileTouched(sender: AnyObject) {
    }
    @IBAction func likeButtonPressed(sender: AnyObject) {
        var query = PFQuery(className: "Posts")
        query.getObjectInBackgroundWithId(object.objectId, block: { (obj:PFObject!, error:NSError!) -> Void in
            
            if error != nil{
                println("Update error \(error.localizedDescription)")
            }else{
                
                var likesNumber = obj.objectForKey("Likes")[0] as Int
                obj["Likes"] = [likesNumber + 1]
                self.likeButton.setTitle("\(likesNumber + 1) likes", forState: UIControlState.Normal)
                obj.save()
            }
            
        })
        
    }
}
