//
//  ViewController.swift
//  StyleLog
//
//  Created by 相澤 隆志 on 2015/04/26.
//  Copyright (c) 2015年 相澤 隆志. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var averageWeight: UILabel!
    @IBOutlet weak var targetWeight: UILabel!
    @IBOutlet weak var achievementRate: UILabel!
    @IBOutlet weak var averageBodyFatPercentage: UILabel!
    @IBOutlet weak var bmiValue: UILabel!
    @IBOutlet weak var remainWeight: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var gradiatePanel: GradiateView!
    
    private var styleLogDatas:[Dictionary<String,Any>]! = []
    private var pageIndex:CGFloat = 0.0
    private var dataManager:DataMngr!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(true)
        //let barHeight:CGFloat = 44
        //self.collectionView.frame = CGRectMake(0,barHeight,self.view.frame.width, self.view.frame.height-barHeight-gradiatePanel.frame.height)
        
        self.dataManager = DataMngr.sharedInstance
        styleLogDatas = self.dataManager.selectAll()
        var flag:Bool = false
        let today:NSDate = NSDate()
        self.setupDate(today)
        let calender:NSCalendar = NSCalendar.currentCalendar()
        let dateComponents:NSDateComponents = NSDateComponents()
        dateComponents.day = -1
        let yesterday:NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: today, options: nil)!
        self.setupDate(yesterday)

        dateComponents.day = -2
        let beforYesterday:NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: today, options: nil)!
        self.setupDate(beforYesterday)
    }

    private func setupDate( soueseDate:NSDate ) {
        var flag:Bool = false
        let count = styleLogDatas.count
        for dict in styleLogDatas {
            println("\(dict.description)")
            if let date:NSDate = dict["date"] as? NSDate {
                if self.IsEqualDate(soueseDate, target: date) {
                    flag = true
                    break
                }
            }
        }
        if flag == false {
            self.dataManager.add(soueseDate)
            styleLogDatas = nil
            styleLogDatas = self.dataManager.selectAll()
            
        }
    }
    private func IsEqualDate( date:NSDate, target:NSDate )->Bool {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let sourceDateStr = dateFormatter.stringFromDate( date )
        let targetDataDtr = dateFormatter.stringFromDate( target )
        var result:Bool
        if sourceDateStr == targetDataDtr {
            result = true
        }else{
            result = false
        }
        return result
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        let index:NSIndexPath! = NSIndexPath(forItem: 1, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }

    func numberOfSectionsInCollectionView(collectionView:UICollectionView)->NSInteger{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styleLogDatas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:MainCollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("MainCollectionCell", forIndexPath: indexPath) as! MainCollectionViewCell
        cell.setupStyleData( styleLogDatas[indexPath.row] as Dictionary<String,Any> )
        println("cellForTtemAtIndex: \(indexPath.row)")
        return cell as UICollectionViewCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width:CGFloat = self.collectionView.bounds.width - 10.0
        let height:CGFloat = self.collectionView.bounds.height
        return CGSizeMake(width, height)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        var flag:Bool = false
        if page > pageIndex {
            /*
            if( page == CGFloat(styleLogDatas.count-2) ) {
                let str:String = String(format:"%d",dataSourceArray.count)
                dataSourceArray.append(str)
            }
            */
        }else{
            if( page < 2) {
                let dict = styleLogDatas[0] as Dictionary<String,Any>
                let baseDate:NSDate = (dict["date"] as? NSDate)!
                let calender:NSCalendar = NSCalendar.currentCalendar()
                let dateComponents:NSDateComponents = NSDateComponents()
                dateComponents.day = -1
                let targetDate:NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: baseDate, options: nil)!
                self.setupDate(targetDate)
                flag = true
            }
        }
        pageIndex = page
        self.collectionView.reloadData()
        
        if flag {
            let index:NSIndexPath! = NSIndexPath(forItem: Int(pageIndex+1), inSection: 0)
            self.collectionView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
        }
        
    }


}

