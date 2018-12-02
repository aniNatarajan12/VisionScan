//
//  TableViewCell.swift
//  VisionScan
//
//  Created by Anirudh Natarajan on 12/1/18.
//  Copyright © 2018 Anirudh Natarajan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var significanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
