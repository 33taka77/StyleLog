//
//  MainCollectionViewCell.swift
//  StyleLog
//
//  Created by 相澤 隆志 on 2015/04/26.
//  Copyright (c) 2015年 相澤 隆志. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    private var styltData:Dictionary<String,Any>?
    
    func setupStyleData( data:Dictionary<String,Any>?) {
        styltData = data
    }
    
}
