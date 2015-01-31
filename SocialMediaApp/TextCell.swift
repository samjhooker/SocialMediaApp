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
    
    
    @IBAction func likesButtonPressed(sender: AnyObject) {
        
        var likesNumber = object.objectForKey("Likes")[0] as Int
        object["likes"] = [likesNumber++]
        
        
    }
    
    override func awakeFromNib() {
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
            
            likesButton.setTitle("\(likesNumber) likes", forState: UIControlState.Normal)
        
    }

    

        
}




}

