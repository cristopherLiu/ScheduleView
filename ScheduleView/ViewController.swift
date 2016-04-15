//
//  ViewController.swift
//  scheduleView
//
//  Created by hjliu on 2016/3/29.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ScheduleViewDelegate{

    /// DATA
    let timeList = [
        NSDate.Parse("08:10")!,
        NSDate.Parse("09:10")!,
        NSDate.Parse("10:10")!,
        NSDate.Parse("11:10")!,
        NSDate.Parse("12:10")!,
        
        NSDate.Parse("13:10")!,
        NSDate.Parse("14:10")!,
        NSDate.Parse("15:10")!,
        NSDate.Parse("16:10")!,
        NSDate.Parse("17:10")!
    ]
    
    let weekList = [
        "一","二","三","四","五","六","日"
    ]
    
    struct BgColor {
        static var color1 = Configuration.ColorSet.color7
        static var color2 = Configuration.ColorSet.color3
    }
    
    let ScheduleList = [
        Schedule(startIndex: 6, spanCount: 1, title: "色彩學", content: "建-B304", backgroundColor: BgColor.color1,viewEvent: {}),
        Schedule(startIndex: 11, spanCount: 2, title: "色彩管理與數位學習", content: "建-B304", backgroundColor: BgColor.color1,viewEvent: {}),
        Schedule(startIndex: 21, spanCount: 2, title: "英語會話1", content: "建-B202", backgroundColor: BgColor.color1,viewEvent: {}),
        Schedule(startIndex: 24, spanCount: 2, title: "英語會話2", content: "建-B202", backgroundColor: BgColor.color1,viewEvent: {}),
        Schedule(startIndex: 41, spanCount: 1, title: "專題製作(一)", content: "建-B203", backgroundColor: BgColor.color1,viewEvent: {}),
        Schedule(startIndex: 44, spanCount: 2, title: "電腦補助設計", content: "建-502", backgroundColor: BgColor.color2,viewEvent: {}),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scheduleView = ScheduleView()
        scheduleView.delegate = self
        scheduleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scheduleView)
        
        let viewsDict = [
            "top":self.topLayoutGuide,
            "bottom":self.bottomLayoutGuide,
            "scheduleView":scheduleView,
            ] as [String:AnyObject]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scheduleView]|", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scheduleView]|", options: [], metrics: nil, views: viewsDict))
    }
    
    func arrayDataForTopHeader()->[AnyObject]{
        return weekList
    }
    
    func arrayDataForLeftHeader()->[AnyObject]{
        return timeList
    }
    
    func arrayDataForContent()->[Schedule]{
        return ScheduleList
    }
}




