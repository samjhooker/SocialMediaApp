//
//  TextCell.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 30/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit
import Foundation

class TextCell: UITableViewCell {
    
    var object:PFObject!

    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var textOutputLabel: UILabel!
    
    @IBOutlet weak var likesButton: UIButton!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var whiteView: UIView!
    
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
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        
        
        let shadowPath = UIBezierPath(rect: whiteView.bounds)
        whiteView.layer.masksToBounds = false
        whiteView.layer.shadowColor = UIColor.blackColor().CGColor
        whiteView.layer.shadowOffset = CGSizeMake(0.5, 0.5)
        whiteView.layer.shadowOpacity = 0.2
        whiteView.layer.shadowPath = shadowPath.CGPath
        
        
        if object != nil{
            println("object is awesome \(object)")
            //retrieve image
            
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
            
            //retrieve other data
            
            usernameLabel.text = object.objectForKey("username")[0] as? String
            textOutputLabel.text = object.objectForKey("message")[0] as? String
            
            var likesNumber: AnyObject! = object.objectForKey("likes")[0]
            
            likesButton.setTitle("\(likesNumber) likes", forState: UIControlState.Normal)
            
            
            
            
            
        }
    }
    
    override func layoutSubviews() {
        
        println(object)
        if object != nil{
            println("object is awesome \(object)")
            //retrieve image
            
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
            
            //retrieve other data
            
            usernameLabel.text = object.objectForKey("username")[0] as? String
            textOutputLabel.text = object.objectForKey("message")[0] as? String
            
            
            var likesNumber: AnyObject! = object.objectForKey("Likes")[0]
            
            likesButton.setTitle("LIKE", forState: UIControlState.Normal)
        
    }

    

        
}




}

