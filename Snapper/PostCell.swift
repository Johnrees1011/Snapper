//
//  PostCell.swift
//  Snapper
//
//  Created by John Rees on 4/21/15.
//  Copyright (c) 2015 John Rees. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var votes: UILabel!
    
    @IBOutlet weak var iView: UIImageView!
    
    @IBOutlet weak var voLabel: UILabel!
    
    
    var query = PFQuery(className:"Post")
    var postObj = PFObject(className: "Post")
    
    

    
    
    
    
    @IBOutlet weak var voteLabel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
   

    
    
    func setPost(posting : PFObject){
        self.postObj = posting
        desc.text = posting["Description"] as? String
     // println(posting["Votes"] as Int)
        voLabel.text = String(posting["Votes"] as! Int)
        if postObj["Description"] != nil{
        let userImageFile = postObj["Photo"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock({
                (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
            if (error != nil) {
                let image2 = UIImage(data:imageData!)
                self.iView.image = image2
               
            }else{
                let image2 = UIImage(data:imageData!)
                self.iView.image = image2
               
            }
        }
        })
    }
    func upVote(sender: AnyObject) {
        let votes = postObj["Votes"] as! Int
        //println(votes)
        let votes2 = votes + 1
        postObj.setValue(votes2, forKey: "Votes")
        
        postObj.save()
         voLabel.text = String(postObj["Votes"] as! Int)
        
    }
    
     func downVote(sender: AnyObject) {
        let votes = postObj["Votes"] as! Int
       // println(votes)
        let votes2 = votes - 1
        postObj.setValue(votes2, forKey: "Votes")
       
        postObj.save()
          voLabel.text = String(postObj["Votes"] as! Int)
       
    }
  
    
    
}
    @IBAction func upVote(sender: AnyObject) {
        let votes = postObj["Votes"] as! Int
        //println(votes)
        let votes2 = votes + 1
        postObj.setValue(votes2, forKey: "Votes")
        
        postObj.save()
        voLabel.text = String(postObj["Votes"] as! Int)

    
    }
    
    @IBAction func dVote(sender: AnyObject) {
        let votes = postObj["Votes"] as! Int
        // println(votes)
        let votes2 = votes - 1
        postObj.setValue(votes2, forKey: "Votes")
        
        postObj.save()
        voLabel.text = String(postObj["Votes"] as! Int)

    
    }
    override func prepareForReuse() {
        
    }
    
    
}
