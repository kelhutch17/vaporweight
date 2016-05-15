//
//  File.swift
//  vaporweight
//
//  Created by Kelly Hutchison on 5/15/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import UIKit

class SessionTableViewCell : UITableViewCell {
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}