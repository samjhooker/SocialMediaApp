//
//  HeaderTableViewCell.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 31/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    
        
        
        var data: AnyObject = kCurrentUser.objectForKey("profilePicture")[0]
        
        
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
        
        
        
        usernameLabel.text = kCurrentUser.username
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
