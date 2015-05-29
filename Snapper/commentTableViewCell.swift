//
//  commentTableViewCell.swift
//  Snapper
//
//  Created by John Rees on 5/13/15.
//  Copyright (c) 2015 John Rees. All rights reserved.
//

import UIKit

class commentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var commentLable: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    var urmom = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setObj(a : String){
        println(a)
       self.urmom = a
        setLabel()
    }
    func setLabel(){
        
        if(self.urmom.isEmpty == false){
            print("Comment should be ")
            println(self.urmom)
            commentLable.text = urmom
        }
       
    }
    
}


