//
//  Global.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 31/01/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import Foundation
import UIKit

class Global {
    
    class func showAlert(title:String, message:String, view:UIViewController){
        
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        view.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
}