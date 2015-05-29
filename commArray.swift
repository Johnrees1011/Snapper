//
//  commArray.swift
//  Snapper
//
//  Created by John Rees on 5/13/15.
//  Copyright (c) 2015 John Rees. All rights reserved.
//

import UIKit

class commArray: PFObject {
    var comments : [NSObject] = []
    
    func setUp(a : NSObject){
        
    }
    func addObj(a : NSObject){
        comments.append(a)
    }
}
