//
//  CObject.swift
//  Snapper
//
//  Created by John Rees on 5/12/15.
//  Copyright (c) 2015 John Rees. All rights reserved.
//

import UIKit
import Parse

class CObject : NSObject {
    var comment = ""
    var votes = 1
    func setUp(comment : String){
        self.comment = comment
    }
    class func parseClassName() -> String! {
        return "Comments"
    }
    func getComment() -> String{
        return self.comment
    }
}
