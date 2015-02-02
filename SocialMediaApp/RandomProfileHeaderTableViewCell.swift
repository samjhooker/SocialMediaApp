//
//  RandomProfileHeaderTableViewCell.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 2/02/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class RandomProfileHeaderTableViewCell: UITableViewCell {
    
    
    var user:PFUser!
    
    var found = false
    
    
    @IBOutlet weak var friendButton: UIButton!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profilePictureCircleView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        
        usernameLabel.text = user.username
        
       // friends button
        
        var friendsList = PFUser.currentUser().objectForKey("friends") as [String]
        for friend in friendsList{
            if friend == user.username{
                found = true
            }
        }
        
        if found{
            friendButton.setTitle("Already Friends", forState: UIControlState.Normal)
        }
        else{
            friendButton.setTitle("tap to Become a Friend", forState: UIControlState.Normal)
        }
        
        
        
        
        
        
        
        //prepare images
        
        var image:UIImage!
        
        var data: AnyObject = user.objectForKey("profilePicture")[0]
        
        data.getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                self.profilePictureImageView.image = UIImage(data:imageData)
                self.profilePictureCircleView.image = UIImage(data:imageData)
            }
        }
        
        profilePictureImageView.layer.masksToBounds = true
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = profilePictureImageView.frame
        profilePictureImageView.addSubview(effectView)
        
        profilePictureCircleView.layer.borderWidth=3.0
        profilePictureCircleView.layer.masksToBounds = false
        profilePictureCircleView.layer.borderColor = UIColor.whiteColor().CGColor
        profilePictureCircleView.layer.cornerRadius = 13
        profilePictureCircleView.layer.cornerRadius = profilePictureCircleView.frame.size.height/2
        profilePictureCircleView.clipsToBounds = true
        
    }
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func friendButtonPressed(sender: AnyObject) {
        
        if found{
            //are friends already
            //do nil
        }else{
            
            found = true
            friendButton.setTitle("Added as a friend", forState: UIControlState.Normal)
            
            PFUser.currentUser().addObject(user.username, forKey: "friends")
            
            
            
        }
        
    }
}
