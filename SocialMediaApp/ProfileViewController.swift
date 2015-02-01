






import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var listOfEveryting:[PFObject]! = []
    
    @IBOutlet weak var tableView: UITableView!
    
    //@IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pullData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return listOfEveryting.count + 1
        
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //nil
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var cell:UITableViewCell!
        
        if indexPath.row == 0{
            var cell = tableView.dequeueReusableCellWithIdentifier("profileHeaderCell") as ProfileHeaderTableViewCell
            cell.ViewController = self
            return cell
        }else{
            
            
            
            var a = listOfEveryting[indexPath.row - 1]
            
            var text:Int = a.objectForKey("text")[0] as Int
            
            
            if text == 1 {
                var cell = tableView.dequeueReusableCellWithIdentifier("textCell") as TextCell
                
                
                cell.object = listOfEveryting[indexPath.row - 1] as PFObject
                
                
                return cell
            }else{
                
                var cell = tableView.dequeueReusableCellWithIdentifier("imageCell") as ContentCell
                
                
                cell.object = listOfEveryting[indexPath.row - 1] as PFObject
                
                
                return cell
                
            }
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        pullData()
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if indexPath.row == 0 {
            return 284
        }
        else if (listOfEveryting[indexPath.row - 1].objectForKey("text")[0] as Int) == 1{
            return 104
        }else{
            return 190
        }
        
        
        
    }
    
    
    
    
    func pullData(){
        
        var query = PFQuery(className: "Posts")
        //query.ascending("createdAt")
        query.addDescendingOrder("createdAt")
        query.whereKey("username", equalTo: PFUser.currentUser().username)
        query.limit = 30
        
        
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            
            if error == nil {
                
                self.listOfEveryting = objects as? [PFObject]
                self.tableView.reloadData()
                
            }else{
                
                println("error retrieving data: \(error.localizedDescription)")
                
            }
            
        }
        
        
        
        
        
    }
    
    
}