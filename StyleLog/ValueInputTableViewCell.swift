//
//  ValueInputTableViewCell.swift
//  StyleLog
//
//  Created by Aizawa Takashi on 2015/04/27.
//  Copyright (c) 2015年 相澤 隆志. All rights reserved.
//

import UIKit

enum KindOfPickerData {
    case weight
    case fat
}


class ValueInputTableViewCell: UITableViewCell ,UIPickerViewDataSource,UIPickerViewDelegate{


    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var pickerViewControl: UIPickerView!
    
    var listOfPickerItem1:[String] = []
    var listOfPickerItem2:[String] = []
    var kindOfPicker:KindOfPickerData = KindOfPickerData.weight
    var isOpen:Bool = false
    var selectWeightValue:CGFloat = 1.0
    var selectFatValue:CGFloat = 10.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupDataPicker( kind:KindOfPickerData ) {
        pickerViewControl.delegate = self
        pickerViewControl.dataSource = self
        
        switch kind {
        case .weight:
            for var i:Int = 0; i < 140; i++ {
                let str:String = String(format:"%d",i)
                listOfPickerItem1.append(str)
            }
            for var j:Int = 0; j < 99;j++ {
                if j % 5 == 0 {
                    let tmpStr:String = String(format:"%d",j)
                    if j == 0 || j == 5 {
                        let str = ".0" + tmpStr
                        listOfPickerItem2.append(str)
                    }else{
                        let str = "." + tmpStr
                        listOfPickerItem2.append(str)
                    }
                }
            }
            pickerViewControl.selectRow(75, inComponent: 0, animated: false)
            pickerViewControl.selectRow(30, inComponent: 1, animated: false)
            pickerViewControl.tag = 0
        case .fat:
            for var i:Int = 0; i < 40; i++ {
                let str:String = String(format:"%d",i)
                listOfPickerItem1.append(str)
            }
            for var j:Int = 0; j < 10;j++ {
                let tmpStr:String = String(format:"%d",j)
                let str = "." + tmpStr
                listOfPickerItem2.append(str)
            }
            pickerViewControl.selectRow(30, inComponent: 0, animated: false)
            pickerViewControl.selectRow(5, inComponent: 1, animated: false)
            pickerViewControl.tag = 1
        default:
        println("")
        }
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return listOfPickerItem1.count
        }else if component == 1 {
            return listOfPickerItem2.count
        }
        return 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var titleStr:String?
        switch component {
        case 0:
            titleStr = listOfPickerItem1[row]
        case 1:
            titleStr = listOfPickerItem2[row]
        default:
            println("error")
            titleStr = nil
        }
        return titleStr
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let label = UILabel(frame: CGRectMake(0, 0, pickerView.frame.width/2.0, 44))
        label.textAlignment = NSTextAlignment.Center
        var titleStr:String?
        switch component {
        case 0:
            titleStr = listOfPickerItem1[row]
        case 1:
            titleStr = listOfPickerItem2[row]
        default:
            println("error")
            titleStr = nil
        }
        label.text = titleStr
        return label
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedWeightUpper:Int = 0
        var selectedWeightLower:Int = 0
        var selectedFatUpper:Int = 0
        var selectedFatLower:Int = 0
        
        if pickerView.tag == 0 {
            selectedWeightUpper = pickerView.selectedRowInComponent(0)
            selectedWeightLower = pickerView.selectedRowInComponent(1)
            let temp:String = listOfPickerItem1[selectedWeightUpper] as String
            let upper:Int = temp.toInt()!
            var str:String = listOfPickerItem2[selectedWeightLower] as String
            str = str.substringFromIndex(advance(str.startIndex, 1))

            let lower:Int = str.toInt()!
            
            selectWeightValue = calWeight(upper, lowerVal: lower)
        }else{

            selectedFatUpper = pickerView.selectedRowInComponent(0)

            selectedFatLower = pickerView.selectedRowInComponent(1)
            
            let temp:String = listOfPickerItem1[selectedFatUpper] as String
            let upper:Int = temp.toInt()!
            var str:String = listOfPickerItem2[selectedFatLower] as String
            str = str.substringFromIndex(advance(str.startIndex, 1))
            
            let lower:Int = str.toInt()!
            
            selectFatValue = calFat(upper, lowerVal: lower)
        }
    }
    
    func getTag()->Int {
        let val = pickerViewControl.tag
        return val
    }
    func getWeightValue()->CGFloat {
        var selectWeightValue:CGFloat = 1.0
        var selectedWeightUpper:Int = 0
        var selectedWeightLower:Int = 0
        selectedWeightUpper = pickerViewControl.selectedRowInComponent(0)
        selectedWeightLower = pickerViewControl.selectedRowInComponent(1)
        let temp:String = listOfPickerItem1[selectedWeightUpper] as String
        let upper:Int = temp.toInt()!
        var str:String = listOfPickerItem2[selectedWeightLower] as String
        str = str.substringFromIndex(advance(str.startIndex, 1))
        
        let lower:Int = str.toInt()!
        
        selectWeightValue = calWeight(upper, lowerVal: lower)
        return selectWeightValue
    }
    func getFatValue()->CGFloat {
        var selectFatValue:CGFloat = 10.0
        var selectedFatUpper:Int = 0
        var selectedFatLower:Int = 0
        selectedFatUpper = pickerViewControl.selectedRowInComponent(0)
        selectedFatLower = pickerViewControl.selectedRowInComponent(1)
        let temp:String = listOfPickerItem1[selectedFatUpper] as String
        let upper:Int = temp.toInt()!
        var str:String = listOfPickerItem2[selectedFatLower] as String
        str = str.substringFromIndex(advance(str.startIndex, 1))
        
        let lower:Int = str.toInt()!
        
        selectFatValue = calFat(upper, lowerVal: lower)
        return selectFatValue
    }
    
    private func calWeight( upperVal:Int,lowerVal:Int )->CGFloat {
        let lower = CGFloat(lowerVal)/100.0
        let upper = CGFloat(upperVal)
        let result:CGFloat = upper + lower
        return result
    }
    private func calFat( upperVal:Int,lowerVal:Int )->CGFloat {
        let lower = CGFloat(lowerVal)/10.0
        let upper = CGFloat(upperVal)
        let result:CGFloat = upper + lower
        return result
    }

}
