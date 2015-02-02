//
//  imagePostViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 2/02/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class imagePostViewController: UIViewController {
    
    
    var object:PFObject!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var otherWhiteView: UIView!
    @IBOutlet weak var whiteView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //shadows for views
        
        
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
        
        
        //load other stuff
        
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
        profileButton.setTitle("View \(username)'s full profile", forState: UIControlState.Normal)
        
        
        data = object.objectForKey("image")[0]
        data.getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                self.mainImage.image = UIImage(data:imageData)
            }
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func profileButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("toFriendsProfileSegue", sender: object.objectForKey("username")[0])
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var view = segue.destinationViewController as RandomUserProfileViewController
        view.username = sender as String
        
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
