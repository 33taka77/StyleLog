//
//  ValueLabelTableViewCell.swift
//  StyleLog
//
//  Created by Aizawa Takashi on 2015/04/27.
//  Copyright (c) 2015年 相澤 隆志. All rights reserved.
//

import UIKit

class ValueLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
