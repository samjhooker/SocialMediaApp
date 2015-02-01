//
//  ContentCell.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 30/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit
import Foundation

class ContentCell: UITableViewCell {
    
    
    var object:PFObject!
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var likesButton: UIButton!
    
    
    @IBAction func likesButtonPressed(sender: AnyObject) {
        
        var query = PFQuery(className: "Posts")
        query.getObjectInBackgroundWithId(object.objectId, block: { (obj:PFObject!, error:NSError!) -> Void in
            
            if error != nil{
                println("Update error \(error.localizedDescription)")
            }else{
                
                var likesNumber = obj.objectForKey("Likes")[0] as Int
                obj["Likes"] = [likesNumber + 1]
                self.likesButton.setTitle("\(likesNumber + 1) likes", forState: UIControlState.Normal)
                obj.save()
            }
            
        })
        
    }
    
    
    
    override func layoutSubviews() {
        
        //profile pic
        
        var data: AnyObject = object.objectForKey("profilePicture")[0]
        data.getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                self.profilePictureView.image = UIImage(data:imageData)
            }
        }
        
        profilePictureView.layer.borderWidth=3.0
        profilePictureView.layer.masksToBounds = false
        profilePictureView.layer.borderColor = UIColor.whiteColor().CGColor
        profilePictureView.layer.cornerRadius = 13
        profilePictureView.layer.cornerRadius = profilePictureView.frame.size.height/2
        profilePictureView.clipsToBounds = true
        
        
        //large image
        
        
        var data2: AnyObject = object.objectForKey("thumbnail")[0]
        data2.getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                self.mainImageView.image = UIImage(data:imageData)
            }
        }
        
        
        //other stuff
        
        usernameLabel.text = object.objectForKey("username")[0] as? String
        var likesNumber: AnyObject! = object.objectForKey("Likes")[0]
        
        likesButton.setTitle("\(likesNumber) likes", forState: UIControlState.Normal)
        
        
        
    }
    
    
    
    
    
    
    
}
