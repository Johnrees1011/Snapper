//
//  InitialTableViewController.swift
//  Snapper
//
//  Created by John Rees on 4/30/15.
//  Copyright (c) 2015 John Rees. All rights reserved.
//

import UIKit

class InitialTableViewController: UITableViewController{
    var postsArray1 : [PFObject] = []
    var segPost = PFObject(className: "Post")
    var pace = 0
    var finished = false
    
    @IBOutlet weak var mode: UISegmentedControl!
    
    
    override func viewDidLoad() {
       //         println(postsArray[0]["Description"] as NSString)
       super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        postsArray1 = []
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
       
        let height = UIApplication.sharedApplication().statusBarFrame.size.height
        let insets = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
        getNew()
        //reloadAfter()
        finished = true
        pace = 0
        
        mode.selectedSegmentIndex = 0
        mode.selectedSegmentIndex = 1
        mode.selectedSegmentIndex = 0
       // bubbleSort()
        tableView.reloadData()
        
    }
 
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }

    @IBAction func didSwitch(sender: AnyObject) {
        activate()
    
    }
    func reUp(){
        getNew()
        
    }
    func activate() {
       // postsArray1.removeAll(keepCapacity: false)
        
        //queryForTable()
        //queryForTable()
        
       // postsArray1.removeAll()
     //  postsArray1.append(PFObject)
       // postsArray1.removeAll()
        
        switch mode.selectedSegmentIndex
        {
        case 0:
            getNew()
            tableView.reloadData()
        case 1:
            grabby()
            bubbleSort()
            tableView.reloadData()

        default:
            break; 
        }
        //grabby()
        
        
        //reloadAfter()
        finished = true
        pace = 0
        
        
        //bubbleSort()
        //postsArray1 = uniq(postsArray1)
        //cleanUp()
        tableView.reloadData()
        
        
       
        
    }
    
    func getPosts(){
        
      //  println(postsArray1.count)
        var query = PFQuery(className:"Posts")
       // query.whereKey("playerName", equalTo:"Sean Plott")
        
        
        query.orderByAscending("PostDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
               
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                            
                           // self.postsArray1.insert(object)
                                self.postsArray1.insert(object as PFObject, atIndex: 0)
                                //self.postsArray1+=[object]
                                
                            
                        
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }

    func grabby(){
        postsArray1.removeAll(keepCapacity: false)
        //postsArray1.removeAtIndex(0)
        pace = 0
        var query = PFQuery(className:"Post")
        //query.whereKey("Votes", equalTo:"1")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
               // println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        //println(object.objectId)
                        //self.postsArray1.append(object)
                        self.postsArray1.append(object)
                        self.tableView.reloadData()
                        self.bubbleSort()
                       println("Condition")
                    
                    }
                }
            } else {
                // Log details of the failure
                
            }
        }
        for PFObject in postsArray1{
            // println("1")
        }
        
        //postsArray1 = clearArray()
       // postsArray1 = uniq(postsArray1)
      
    }
    
    
    func getNew(){
        postsArray1.removeAll(keepCapacity: false)
        //postsArray1.removeAtIndex(0)
        pace = 0
        var query = PFQuery(className:"Post")
        //query.whereKey("Votes", equalTo:"1")
        query.orderByDescending("PostDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                // println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        //println(object.objectId)
                        //self.postsArray1.append(object)
                        self.postsArray1.append(object)
                        self.tableView.reloadData()
                      //  self.bubbleSort()
                        println("Condition")
                        
                    }
                }
            } else {
                // Log details of the failure
                
            }
        }
        for PFObject in postsArray1{
            // println("1")
        }
        
        //postsArray1 = clearArray()
        // postsArray1 = uniq(postsArray1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }



  

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        

        println(postsArray1.count)
        return postsArray1.count
    }

    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as! PostCell
        //print(postsArray1[25])
       // cell.setPost(postsArray[25])
       // cell.desc.text = postsArray[10]["Descripton"] as NSString
        //if pace < postsArray1.count {

        if finished == true{
        var post = PFObject(className: "Post")
        post = self.postsArray1[indexPath.row]
            let userImageFile = post["Photo"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    if (error != nil) {
                        let image2 = UIImage(data:imageData!)
                        cell.iView.image = image2
                        cell.desc.text = post["Description"] as? String
                        cell.voLabel.text = String(post["Votes"] as! Int)
                        cell.postObj = post
                    }else{
                        let image2 = UIImage(data:imageData!)
                        cell.iView.image = image2
                        cell.desc.text = post["Description"] as? String
                        cell.voLabel.text = String(post["Votes"] as! Int)
                        cell.postObj = post
                    }
                }
            })

            
       // }
           
            
        }
       // println(pace)
        pace = pace + 1
        return cell
        
      
    
    }
    func reloadAfter(){
        pace = 0
        postsArray1 = []
        var query = PFQuery(className:"Post")
        //query.whereKey("Votes", equalTo:"1")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
             //   println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        //println(object.objectId)
                        self.postsArray1.append(object)
                    }
                }
            } else {
                // Log details of the failure
               // println("Error: \(error) \(error.userInfo!)")
            }
        }
        for PFObject in postsArray1{
            // println("1")
        }
    tableView.reloadData()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier != "post"{
        var dvc = segue.destinationViewController as! LargeViewController
        var index1 = tableView.indexPathForSelectedRow()?.row
        dvc.setUp(postsArray1[index1!])
        }
        
    }
  
    

    func bubbleSort(){
        var didSwap = false
        var swapped = true
        while(swapped){
            swapped = false
 
            if(postsArray1.count > 1){
            
            for index in 1...postsArray1.count-1{
                
                
                if postsArray1[index]["Votes"] as? Int > postsArray1[index-1]["Votes"] as? Int
                {
                   
                    let tmp = postsArray1[index-1]
                    
                    // this is the swap
                    // move n to the posistion of n-1
                    postsArray1[index-1] = postsArray1[index]
                    
                    // place n-1 where n was
                    postsArray1[index] = tmp
                    
                    swapped = true
                    didSwap = true
                }
            }
        }
        
        
        }
        
        if didSwap == true{
        
     tableView.reloadData()
        }
    
    }
    func newSort(){
        var didSwap = false
        var swapped = true
        while(swapped){
            swapped = false
            
            if(postsArray1.count > 1){
                
                for index in 1...postsArray1.count-1{
                    
                    
                    if postsArray1[index]["PostDate"] as? Int > postsArray1[index-1]["PostDate"] as? Int
                    {
                        
                        let tmp = postsArray1[index-1]
                        
                        // this is the swap
                        // move n to the posistion of n-1
                        postsArray1[index-1] = postsArray1[index]
                        
                        // place n-1 where n was
                        postsArray1[index] = tmp
                        
                        swapped = true
                        didSwap = true
                    }
                }
            }
            
            
        }
        
        if didSwap == true{
            
            tableView.reloadData()
        }
        
    }

    
    func distinct<S: SequenceType, E: Equatable where E==S.Generator.Element>(source: S) -> [E]
    {
        var unique = [E]()
        
        for item in source
        {
            if !contains(unique, item)
            {
                unique.append(item)
            }
        }
        return unique
    }
   

    func uniq<T: Hashable>(lst: [T]) -> [T] {
        var uniqueSet = [T : Void](minimumCapacity: lst.count)
        for x in lst {
            uniqueSet[x] = ()
        }
        return Array(uniqueSet.keys)
    }
    func cleanUp(){
      
        if(postsArray1.count > 0){
         var count = 0
        var temp = postsArray1[count]
        for index in 0...postsArray1.count{
            if(postsArray1[index]["Description"]as! String == temp["Description"] as! String){
                postsArray1.removeAtIndex(index)
            }
            
        }
        if(count != postsArray1.count - 1){
            cleanUp()
        }
    }
    }
    
    
}



