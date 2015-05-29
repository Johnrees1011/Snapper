//
//  baseTableView.swift
//  Snapper
//
//  Created by John Rees on 4/21/15.
//  Copyright (c) 2015 John Rees. All rights reserved.
//

import UIKit

class baseTableView: UITableView {
    func viewDidLoad(){
       
        fresh()
    }
    func fresh(){
        var query = PFQuery(className:"GameScore")
      
        query.whereKey("Votes", equalTo:"1")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                               // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                    }
                }
            } else {
                // Log details of the failure
                
            }
        }
        
    }
}
