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
    var clickIndex:Int = 100
    
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
            let expandCell:ValueInputTableViewCell = cell as! ValueInputTableViewCell
            expandCell.setupDataPicker(KindOfPickerData.weight)
            expandCell.unit.text = "Kg"
            expandCell.pickerView.hidden = true
            expandCell.unit.hidden = true
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
            
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("expandInputCell") as! UITableViewCell
            let expandCell:ValueInputTableViewCell = cell as! ValueInputTableViewCell
            expandCell.setupDataPicker(KindOfPickerData.fat)
            expandCell.unit.text = "%"
            expandCell.pickerView.hidden = true
            expandCell.unit.hidden = true
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("expandInputCell") as! UITableViewCell
            let expandCell:ValueInputTableViewCell = cell as! ValueInputTableViewCell
            expandCell.setupDataPicker(KindOfPickerData.weight)
            expandCell.unit.text = "Kg"
            expandCell.pickerView.hidden = true
            expandCell.unit.hidden = true
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
        case 7:
            cell = tableView.dequeueReusableCellWithIdentifier("expandInputCell") as! UITableViewCell
            let expandCell:ValueInputTableViewCell = cell as! ValueInputTableViewCell
            expandCell.setupDataPicker(KindOfPickerData.fat)
            expandCell.unit.text = "%"
            expandCell.pickerView.hidden = true
            expandCell.unit.hidden = true
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
            println("\(indexPath)")
            let expandCell:ValueInputTableViewCell = cell as! ValueInputTableViewCell
            /*
            if expandCell.isOpen == false {
                expandCell.pickerView.hidden = true
                expandCell.unit.hidden = true
                height = 0
            }else{
                height = 160
            }
            */
            if clickIndex == 100{
                height = 0
            }else{
                if clickIndex == indexPath.row {
                    height = 160
                }else{
                    height = 0
                }
            }
        }else{
            height = 30
        }
        return height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let expandIndex:NSIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
        if self.isExpandCell(tableView, atIndexPath: expandIndex) {
            tableView.beginUpdates()
            self.togglePicker(tableView, atIndexPath: expandIndex)
            tableView.endUpdates()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func isExpandCell(tableView: UITableView, atIndexPath index:NSIndexPath)->Bool {
        let cell:UITableViewCell = self.tableView(tableView, cellForRowAtIndexPath: index)
        let isExpand:Bool = cell.reuseIdentifier == "expandInputCell"
        return isExpand
    }
    func togglePicker(tableView: UITableView, atIndexPath index:NSIndexPath) {
        println("\(index)")
        let cell:UITableViewCell = self.tableView(tableView, cellForRowAtIndexPath: index)
        let expandCell:ValueInputTableViewCell = cell as! ValueInputTableViewCell
        //let tag = expandCell.tag
        if clickIndex == 100 {
            clickIndex == index.row
        }else{
            clickIndex = 100
        }
        /*
        if expandCell.isOpen == false {
            expandCell.isOpen = true
        }else{
            expandCell.isOpen = false
        }
        */
//        expandCell.tag = ~expandCell.tag
        expandCell.pickerView.hidden = !expandCell.pickerView.hidden
        expandCell.unit.hidden = !expandCell.unit.hidden
    }

}
