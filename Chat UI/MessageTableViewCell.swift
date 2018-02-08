//
//  MessageTableViewCell.swift
//  Chat UI
//
//  Created by Renish Dadhaniya iMac on 06/02/18.
//  Copyright © 2018 GlobeSync Technologies. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtLBL: UILabel!
    @IBOutlet weak var msgBoxTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var msgBoxLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bubbleImg: UIImageView!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var msgTV: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

}
