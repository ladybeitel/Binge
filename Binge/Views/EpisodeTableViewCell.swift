//
//  EpisodeTableViewCell.swift
//  Binge
//
//  Created by Ciara Beitel on 12/30/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var episodeTitleLabel: UILabel!
    
    @IBOutlet weak var episodeNumberLabel: UILabel!
    
    
    @IBOutlet weak var episodeWatchedSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
