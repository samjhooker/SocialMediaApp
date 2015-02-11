//
//  FriendListTableViewCell.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 2/02/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class FriendListTableViewCell: UITableViewCell {
    
    var user:PFUser!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
  
    
    override func layoutSubviews() {
        super.awakeFromNib()
        // Initialization code
        usernameLabel.text = user.objectForKey("username") as? String
        
        
        var data: AnyObject = user.objectForKey("profilePicture")[0]
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
        
        
        let shadowPath = UIBezierPath(rect: whiteView.bounds)
        whiteView.layer.masksToBounds = false
        whiteView.layer.shadowColor = UIColor.blackColor().CGColor
        whiteView.layer.shadowOffset = CGSizeMake(0.5, 0.5)
        whiteView.layer.shadowOpacity = 0.2
        whiteView.layer.shadowPath = shadowPath.CGPath
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
