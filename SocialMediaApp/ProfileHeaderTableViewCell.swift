//
//  ProfileHeaderTableViewCell.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 1/02/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit
import MobileCoreServices


class ProfileHeaderTableViewCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //var object:PFObject!
    //var user:PFUser!
    var ViewController:UIViewController!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var profilePictureCircleView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameLabel.text = PFUser.currentUser().username
        
        var image:UIImage!
        
        var data: AnyObject = PFUser.currentUser().objectForKey("profilePicture")[0]
        
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
    
    
    
    
    @IBOutlet weak var editButtonPressed: UIButton!

    @IBAction func editButtonTapped(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){ //checks if camera is availiable
            var cameraController = UIImagePickerController() //creates instance of media object
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera //selects the media object as a camera
            
            let mediaTypes:[AnyObject] = [kUTTypeImage] // abstract type, specifing image data
            cameraController.mediaTypes = mediaTypes // media type is an image
            
            cameraController.allowsEditing  = false
            
            ViewController.presentViewController(cameraController, animated: true, completion: nil)// present the camera (actually opens it)
            
        }
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            var photoLibraryController = UIImagePickerController()
            photoLibraryController.delegate = self
            photoLibraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            photoLibraryController.mediaTypes = mediaTypes
            photoLibraryController.allowsEditing = false
            ViewController.presentViewController(photoLibraryController, animated: true, completion: nil)
        }
        else{
            Global.showAlert("Not Available", message: "Camera or galery not availiable", view: ViewController)
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        var data = UIImageJPEGRepresentation(image, 0.08)
        var file = PFFile(data: data)
        
        PFUser.currentUser()["profilePicture"] = [file]
        PFUser.currentUser().save()
        
        
        //set profile pic as post
        var object = PFObject(className: "Posts")
        object.addObject(PFUser.currentUser().username, forKey: "username")
        object.addObject(false, forKey: "text")
        
        let imageData = UIImageJPEGRepresentation(image as UIImage, 0.3)
        let imageFile: PFFile = PFFile(data: imageData)
        let thumbnailData = UIImageJPEGRepresentation(image as UIImage, 0.05)
        let thumbnailFile: PFFile = PFFile(data: imageData)
        
        
        object.addObject(imageFile, forKey: "image")
        object.addObject(thumbnailFile, forKey: "thumbnail")
        
        
        
        object.addObject(0, forKey: "Likes")
        object.addObject((kCurrentUser.objectForKey("profilePicture")[0]), forKey: "profilePicture")
        //object.addObject(inputTextField.text, forKey: "message")
        
        object.save()
        
        ViewController.dismissViewControllerAnimated(true, completion: nil)
        //ViewController.pullData()
        
        
    }
    

}
