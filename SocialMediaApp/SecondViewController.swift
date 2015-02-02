//
//  SecondViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 30/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit
import MobileCoreServices

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    
    var imagePost:UIImage!
    
    
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
    
    
    
    //Camera Functions
    
    
    

    @IBOutlet weak var addImagesButton: UIButton!

    @IBAction func addImagesButtonPressed(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){ //checks if camera is availiable
            var cameraController = UIImagePickerController() //creates instance of media object
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera //selects the media object as a camera
            
            let mediaTypes:[AnyObject] = [kUTTypeImage] // abstract type, specifing image data
            cameraController.mediaTypes = mediaTypes // media type is an image
            
            cameraController.allowsEditing  = false
            
            self.presentViewController(cameraController, animated: true, completion: nil)// present the camera (actually opens it)
            
        }
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            var photoLibraryController = UIImagePickerController()
            photoLibraryController.delegate = self
            photoLibraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            photoLibraryController.mediaTypes = mediaTypes
            photoLibraryController.allowsEditing = false
            self.presentViewController(photoLibraryController, animated: true, completion: nil)
        }
        else{
            Global.showAlert("Not Available", message: "Camera or galery not availiable", view: self)
        }

    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.imagePost = image as UIImage
        addImagesButton.setTitle("image Selected, ready to post", forState: UIControlState.Normal)
        self.dismissViewControllerAnimated(true, completion: nil)//dismisses image picker controller
    }
    
    
    
    
    
    
    
    
    
    @IBAction func postImageButtonPressed(sender: AnyObject) {
        
        if imagePost == nil {
            Global.showAlert("no image selected", message: "you must add an image before you can post it", view: self)
        }else{
            
            
            
            var object = PFObject(className: "Posts")
            object.addObject(PFUser.currentUser().username, forKey: "username")
            object.addObject(false, forKey: "text")
            
            let imageData = UIImageJPEGRepresentation(self.imagePost as UIImage, 0.3)
            let imageFile: PFFile = PFFile(data: imageData)
            let thumbnailData = UIImageJPEGRepresentation(self.imagePost as UIImage, 0.05)
            let thumbnailFile: PFFile = PFFile(data: imageData)
            
            
            object.addObject(imageFile, forKey: "image")
            object.addObject(thumbnailFile, forKey: "thumbnail")
            
            
            
            object.addObject(0, forKey: "Likes")
            object.addObject((kCurrentUser.objectForKey("profilePicture")[0]), forKey: "profilePicture")
            //object.addObject(inputTextField.text, forKey: "message")
            
            object.save()
            Global.showAlert("Saved", message: "the post has been published", view: self)
            
            
            
            
            
        }
        
    }
}

