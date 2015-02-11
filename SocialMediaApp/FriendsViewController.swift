//
//  FriendsViewController.swift
//  SocialMediaApp
//
//  Created by Samuel Hooker on 2/02/15.
//  Copyright (c) 2015 Jocus Interactive. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var friends:[PFUser] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        self.getFriends()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        var friendslist = PFUser.currentUser().objectForKey("friends") as [String]
        self.performSegueWithIdentifier("toFriendsProfileSegue", sender: friendslist[indexPath.row])
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var view = segue.destinationViewController as RandomUserProfileViewController
        view.username = sender as String
        
    }
    
    
    
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("friendsListCell") as FriendListTableViewCell
        
        cell.user = friends[indexPath.row] as PFUser
        println(cell.user.username)
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        getFriends()
        
    }
    
    
   
    
    
    
    
    
    
    func getFriends(){
        
        var friendslist = PFUser.currentUser().objectForKey("friends") as [String]
        println(friendslist)
        //friends = []
        
        var queryList:[PFQuery]=[]
        
        
        
        for i in friendslist{
            var query = PFUser.query()
            queryList.append(query.whereKey("username", equalTo: i))
        }
        
        
        
        var querys = PFQuery.orQueryWithSubqueries(queryList)
        querys.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                self.friends = results as [PFUser]
                
            }
        }
            
            
        tableView.reloadData()
    }

}
