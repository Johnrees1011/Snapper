//
//  LargeViewController.swift
//  Snapper
//
//  Created by John Rees on 4/21/15.
//  Copyright (c) 2015 John Rees. All rights reserved.
//


import UIKit
import AVFoundation
import Parse
class LargeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    var objId = ""
  //  var postObj = PFObject(className: "Post")
    var commentArray : [String] = []
  
   var postal = PFObject(className: "Post")
    var count = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    var posted = false
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var commentTextBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateL: UILabel!
    
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80.0
        commentArray.append("")
    }
    func setUp(postObj : PFObject){
        
        postal = postObj
      
        let pDescription = postObj["Description"] as? String
       // print(pDescription)
   // descLabel.text = "Hello World"
        let pDate = postObj["PostDate"] as! NSDate
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy hh:mm a"
     //   dateLabel.text =  dateFormatter.stringFromDate(pDate)
    
        
        
        
        let userImageFile = postObj["Photo"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock({
            (imageData: NSData?, error: NSError?) -> Void in
            if (error == nil) {
                let image2 = UIImage(data:imageData!)
                self.imageView.image = image2
                self.descLabel.text = pDescription
                self.dateL.text = dateFormatter.stringFromDate(pDate)
                self.commentArray = postObj["Comments"] as! Array
                self.tableView.reloadData()
                self.tableView.reloadData()
                println(self.commentArray)
            }else{
                let image2 = UIImage(data:imageData!)
                self.imageView.image = image2
                self.descLabel.text = pDescription
                self.dateL.text = dateFormatter.stringFromDate(pDate)
                self.commentArray = postObj["Comments"] as! Array
                println(self.commentArray)
                self.tableView.reloadData()
                self.tableView.reloadData()
            }
        })

        
    }
    @IBAction func postComment(sender: AnyObject) {
        count = 0
       // var userComment = CObject()
         //   userComment.setUp(commentTextBox.text)
            commentArray.append(commentTextBox.text)
        
   
        postal["Comments"] = commentArray
            postal.saveInBackground()
        commentTextBox.text = ""
           tableView.reloadData()
        self.view.endEditing(true)
        }
    
    
    @IBAction func dismissView(sender: AnyObject) {
        if posted == false{
        self.dismissViewControllerAnimated(true, completion: nil)
        }else{
                performSegueWithIdentifier("postToMain", sender: self)
        }
    }
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier != "PostToMain"{
        var dvc = segue.destinationViewController as! InitialTableViewController
        dvc.reloadAfter()
        dvc.getNew()
        dvc.bubbleSort()
        
        dvc.tableView.reloadData()
        dvc.tableView.reloadData()
        dvc.mode.selectedSegmentIndex = 0
        dvc.mode.selectedSegmentIndex = 1
        dvc.mode.selectedSegmentIndex = 0
        dvc.reloadAfter()
        dvc.getNew()
        dvc.bubbleSort()
        dvc.reUp()
        dvc.tableView.reloadData()
        dvc.tableView.reloadData()
    }
    if segue.identifier != "post"{
        var dvc = segue.destinationViewController as! InitialTableViewController
        dvc.reloadAfter()
        dvc.getNew()
        dvc.bubbleSort()
        dvc.tableView.reloadData()
        dvc.tableView.reloadData()
       dvc.mode.selectedSegmentIndex = 0
        dvc.mode.selectedSegmentIndex = 1
         dvc.mode.selectedSegmentIndex = 0
        dvc.reloadAfter()
        dvc.getNew()
        dvc.bubbleSort()
        dvc.reUp()
        dvc.tableView.reloadData()
        dvc.tableView.reloadData()
    }
    

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commentArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let comms : [String] = postal["Comments"] as! Array
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! commentTableViewCell
    
        
        println(commentArray.count)
        
            
        cell.setObj(commentArray[indexPath.row])
        
        
        
        return cell
    }
     func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    }
    


