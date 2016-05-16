//
//  HighScoreCell.swift
//  vaporweight
//
//  Created by fnord on 5/15/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import UIKit

class HighScoreCell: UITableViewCell {

    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
