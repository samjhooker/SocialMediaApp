//
//  SearchViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 4/02/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var entrytextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        let shadowPath = UIBezierPath(rect: whiteView.bounds)
        whiteView.layer.masksToBounds = false
        whiteView.layer.shadowColor = UIColor.blackColor().CGColor
        whiteView.layer.shadowOffset = CGSizeMake(0.5, 0.5)
        whiteView.layer.shadowOpacity = 0.2
        whiteView.layer.shadowPath = shadowPath.CGPath
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func searchButtonPressed(sender: AnyObject) {
        
        if entrytextField.text == ""{
            
            Global.showAlert("no", message: "Please enter email or username", view: self)
            
        }else{
            
            var query = PFUser.query()
            query.whereKey("username", equalTo: entrytextField.text)
            var otherQuery = PFUser.query()
            otherQuery.whereKey("email", equalTo: entrytextField.text)
            
            var wantedUser: PFUser! = nil
            
            var querys = PFQuery.orQueryWithSubqueries([query, otherQuery])
            querys.findObjectsInBackgroundWithBlock {
                (results: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    
                    // println(results, results.isEmpty)
                    if results.isEmpty == false{
                        wantedUser = results[0] as PFUser
                    }
                    
                    if wantedUser == nil{
                        Global.showAlert("No user", message: "make sure to be specific about the users name/email", view: self)
                    }else{
                        
                        self.performSegueWithIdentifier("searchToProfileSegue", sender: wantedUser.username)
                        
                    }
                    
                }
                
            }
            
            
            
            
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var view = segue.destinationViewController as RandomUserProfileViewController
        view.username = sender as String
        
    }
    
}