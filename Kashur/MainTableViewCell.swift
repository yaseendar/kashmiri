//
//  MainTableViewCell.swift
//  Kashur
//
//  Created by Abdul Basit on 04/09/18.
//  Copyright © 2018 Abdul Basit. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var wordsLabel: UILabel!
    
    @IBOutlet weak var speakerButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
