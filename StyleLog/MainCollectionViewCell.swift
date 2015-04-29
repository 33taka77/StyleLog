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
  
    private var datas:[NSIndexPath] = []
    private var styltData:Dictionary<String,Any>?
    var clickIndex:Int = -1
    var currentDataCount = 4
    
    func setupStyleData( data:Dictionary<String,Any>?) {
        styltData = data
        tableView.delegate = self
        tableView.dataSource = self
        datas.removeAll(keepCapacity: false)
        for var i:Int = 0; i < currentDataCount; i++ {
            let index:NSIndexPath = NSIndexPath(forItem: i, inSection: 0)
            datas.append(index)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = datas.count
        println("print")
        return datas.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        if isChildCell(indexPath) {
            cell = tableView.dequeueReusableCellWithIdentifier("expandInputCell") as! UITableViewCell
            let expandCell:ValueInputTableViewCell = cell as! ValueInputTableViewCell
            switch clickIndex {
            case 0:
                expandCell.setupDataPicker(KindOfPickerData.weight)
                expandCell.unit.text = "Kg"
            case 1:
                expandCell.setupDataPicker(KindOfPickerData.fat)
                expandCell.unit.text = "%"
            case 2:
                expandCell.setupDataPicker(KindOfPickerData.weight)
                expandCell.unit.text = "Kg"
            case 3:
                expandCell.setupDataPicker(KindOfPickerData.fat)
                expandCell.unit.text = "%"
            default:
                println("error")
            }
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("valueLabelCell") as! UITableViewCell
            let topCell:ValueLabelTableViewCell = cell as! ValueLabelTableViewCell
            if clickIndex == -1 {
                switch indexPath.row {
                case 0:
                    topCell.mainLabel.text = "朝 体重"
                    topCell.unitLabel.text = "Kg"
                    topCell.valueLabel.text = "30.0"
                case 1:
                    topCell.mainLabel.text = "朝 体脂肪率"
                    topCell.unitLabel.text = "%"
                    topCell.valueLabel.text = "30.0"
                case 2:
                    topCell.mainLabel.text = "夕 体重"
                    topCell.unitLabel.text = "Kg"
                    topCell.valueLabel.text = "30.0"
                case 3:
                    topCell.mainLabel.text = "夕 体脂肪率"
                    topCell.unitLabel.text = "%"
                    topCell.valueLabel.text = "30.0"
                default:
                    println("error")
                }
            }else{
            switch clickIndex {
                case 0:
                    switch indexPath.row {
                    case 0:
                        topCell.mainLabel.text = "朝 体重"
                        topCell.unitLabel.text = "Kg"
                        topCell.valueLabel.text = "20.0"
                    case 2:
                        topCell.mainLabel.text = "朝 体脂肪率"
                        topCell.unitLabel.text = "%"
                        topCell.valueLabel.text = "20.0"
                    case 3:
                        topCell.mainLabel.text = "夕 体重"
                        topCell.unitLabel.text = "Kg"
                        topCell.valueLabel.text = "20.0"
                    case 4:
                        topCell.mainLabel.text = "夕 体脂肪率"
                        topCell.unitLabel.text = "%"
                        topCell.valueLabel.text = "20.0"
                    default:
                        println("error")
                    }
                case 1:
                    switch indexPath.row {
                    case 0:
                        topCell.mainLabel.text = "朝 体重"
                        topCell.unitLabel.text = "Kg"
                    case 1:
                        topCell.mainLabel.text = "朝 体脂肪率"
                        topCell.unitLabel.text = "%"
                    case 3:
                        topCell.mainLabel.text = "夕 体重"
                        topCell.unitLabel.text = "Kg"
                    case 4:
                        topCell.mainLabel.text = "夕 体脂肪率"
                        topCell.unitLabel.text = "%"
                    default:
                        println("error")
                    }
                case 2:
                    switch indexPath.row {
                    case 0:
                        topCell.mainLabel.text = "朝 体重"
                        topCell.unitLabel.text = "Kg"
                    case 1:
                        topCell.mainLabel.text = "朝 体脂肪率"
                        topCell.unitLabel.text = "%"
                    case 2:
                        topCell.mainLabel.text = "夕 体重"
                        topCell.unitLabel.text = "Kg"
                    case 4:
                        topCell.mainLabel.text = "夕 体脂肪率"
                        topCell.unitLabel.text = "%"
                    default:
                        println("error")
                    }
                case 3:
                    switch indexPath.row {
                    case 0:
                        topCell.mainLabel.text = "朝 体重"
                        topCell.unitLabel.text = "Kg"
                    case 1:
                        topCell.mainLabel.text = "朝 体脂肪率"
                        topCell.unitLabel.text = "%"
                    case 2:
                        topCell.mainLabel.text = "夕 体重"
                        topCell.unitLabel.text = "Kg"
                    case 3:
                        topCell.mainLabel.text = "夕 体脂肪率"
                        topCell.unitLabel.text = "%"
                    default:
                        println("error")
                    }
                default:
                    println("error")
                }
            }
        }
        //var cell:UITableViewCell
        return cell
    }
    
    private func isChildCell( index:NSIndexPath )->Bool {
        var result:Bool = false
        if clickIndex > -1 && index.row > clickIndex && index.row <= clickIndex+1 {
            result = true
        }
        return result
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell:UITableViewCell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        var height:CGFloat
        if isChildCell(indexPath) {
            height = 150
        }else{
            height = 50
        }
        return height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isChildCell(indexPath) {
            return
        }else{
            self.tableView.beginUpdates()
            if clickIndex == indexPath.row {
                let (tag, val) = getValueToLabel( tableView, indexPath: indexPath )
                let cell:ValueLabelTableViewCell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! ValueLabelTableViewCell
                if tag == 0 {
                    let str:String = String(format: "%.2f", arguments: [val])
                    cell.valueLabel.text = str
                }else{
                    cell.valueLabel.text = String(format: "%.1f", arguments: [val])
                }
                closeCell(indexPath.row)
                clickIndex = -1
            }else{
                if clickIndex > -1 {
                    closeCell(clickIndex)
                }
                if clickIndex > -1 && indexPath.row > clickIndex {
                    clickIndex = indexPath.row-1
                }else{
                    clickIndex = indexPath.row
                }
                openCell(clickIndex)
            }
            self.tableView.endUpdates()
            let cell:ValueLabelTableViewCell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as! ValueLabelTableViewCell
            cell.valueLabel.text = "yyyyy"
        }
        /*
        let expandIndex:NSIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
        if self.isExpandCell(tableView, atIndexPath: expandIndex) {
            tableView.beginUpdates()
            self.togglePicker(tableView, atIndexPath: expandIndex)
            tableView.endUpdates()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        */
    }
    
    private func closeCell( index:Int ) {
        let removeIndexPath:NSIndexPath = NSIndexPath(forItem: index+1, inSection: 0)
        var removePaths:NSMutableArray = NSMutableArray()
        removePaths.addObject(removeIndexPath)
        self.tableView.deleteRowsAtIndexPaths(removePaths as [AnyObject], withRowAnimation: UITableViewRowAnimation.Fade)
        datas.removeAtIndex(index)
        currentDataCount = datas.count
        /*
        for var index:Int = 0; index < datas.count; index++ {
            if datas[index] as NSIndexPath == removeIndexPath {
                datas.removeAtIndex(index)
                currentDataCount = datas.count
            }
        }
        */
    }
    private func openCell( index:Int ) {
        let insertIndexPath:NSIndexPath = NSIndexPath(forItem: index+1, inSection: 0)
        var insertPaths:NSMutableArray = NSMutableArray()
        insertPaths.addObject(insertIndexPath)
        self.tableView.insertRowsAtIndexPaths(insertPaths as [AnyObject], withRowAnimation: UITableViewRowAnimation.Fade)
        datas.append(insertIndexPath)
        currentDataCount = datas.count
    }
    
    private func getValueToLabel( tableView:UITableView, indexPath:NSIndexPath )->(Int,CGFloat) {
        let targetIndexPath:NSIndexPath = NSIndexPath(forItem: indexPath.row+1, inSection: 0)
        let cell:ValueInputTableViewCell = self.tableView(tableView, cellForRowAtIndexPath: targetIndexPath) as! ValueInputTableViewCell
        var result:CGFloat
        var tag:Int = cell.getTag()
        if tag == 0 {
            result = cell.getWeightValue()
        }else{
            result = cell.getFatValue()
        }
        return (tag,result)
    }
    /*
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
    */

}
