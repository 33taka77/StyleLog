//
//  MainCollectionViewCell.swift
//  StyleLog
//
//  Created by 相澤 隆志 on 2015/04/26.
//  Copyright (c) 2015年 相澤 隆志. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
  
    private var styltData:Dictionary<String,Any>?
    
    func setupStyleData( data:Dictionary<String,Any>?) {
        styltData = data
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("expandInputCell") as! UITableViewCell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("expandInputCell") as! UITableViewCell
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("expandInputCell") as! UITableViewCell
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
        case 7:
            cell = tableView.dequeueReusableCellWithIdentifier("expandInputCell") as! UITableViewCell
       default:
            println("error")
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell:UITableViewCell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        var height:CGFloat
        if self.isExpandCell(tableView, atIndexPath: indexPath) {
            if cell.tag == 0 {
                height = 0
            }else{
                height = 30
            }
        }else{
            height = 30
        }
        return height
    }
    
    func isExpandCell(tableView: UITableView, atIndexPath index:NSIndexPath)->Bool {
        let cell:UITableViewCell = self.tableView(tableView, cellForRowAtIndexPath: index)
        let isExpand:Bool = (cell.reuseIdentifier == "expandMorningWeightCell") || (cell.reuseIdentifier == "ExpandMorningFatCell")
        return isExpand
    }
    func togglePicker(tableView: UITableView, atIndexPath index:NSIndexPath) {
        let cell:UITableViewCell = self.tableView(tableView, cellForRowAtIndexPath: index)
        cell.tag = ~cell.tag
        //self.dataPicker.hidden = !self.dataPicker.hidden
    }

}
