//
//  Extension.swift
//  scheduleView
//
//  Created by hjliu on 2016/3/30.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}

public func -(lhs: NSDate, rhs: NSDate) -> NSTimeInterval {
    return lhs.timeIntervalSinceDate(rhs)
}

extension NSDate: Comparable { }

extension NSDate{
    
    class func Parse(dateString:String!)->NSDate?{
        if dateString == nil {
            return nil
        }
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        
        dateFormatter.dateFormat = "HH:mm"
        if let date = dateFormatter.dateFromString(dateString) {
            return date
        }
        return nil
    }
    
    func Hour()->String{
        let hour = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: self).hour
        return String(format: "%02d", hour)
    }
    
    func Day()->String{
        let day = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self).day
        return String(format: "%02d", day)
    }
    
    func Week()->String{
        let Weekday = NSCalendar.currentCalendar().components(NSCalendarUnit.Weekday, fromDate: self).weekday
        let map = ["","日","一","二","三","四","五","六"]
        
        return map[Weekday]
    }
    
    func Month()->String{
        let month = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self).month
        //let map = ["","1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
        
        return String(format: "%d", month)
    }
    
    func Year()->String{
        let year = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: self).year
        return "\(year)"
    }
    
    func to_YMD_String()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.stringFromDate(self)
    }
    
    func to_HMS_String()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.stringFromDate(self)
    }
    
    func to_HM_String()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.stringFromDate(self)
    }
    
    func toString()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter.stringFromDate(self)
    }
    
    func toNormalString()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm:ss"
        return dateFormatter.stringFromDate(self)
    }
    
    func addMonths(month:Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let offsetComponents = NSDateComponents()
        offsetComponents.month = month
        return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func addSecond(sec:Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let offsetComponents = NSDateComponents()
        offsetComponents.second = sec
        return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func addHour(hour:Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let offsetComponents = NSDateComponents()
        offsetComponents.hour = hour
        return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func addDay(day:Int)->NSDate{
        let calendar = NSCalendar.currentCalendar()
        let offsetComponents = NSDateComponents()
        offsetComponents.day = day
        return calendar.dateByAddingComponents(offsetComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func firstDateOfMonth(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        components.day = 1
        
        return calendar.dateFromComponents(components)!
    }
    
    func lastDateOfMonth(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        components.day = 0
        components.month = components.month + 1
        
        return calendar.dateFromComponents(components)!
    }
    
    func beginningOfDay(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        return calendar.dateFromComponents(components)!
    }
    
    func dateWithDay(day:Int , calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        components.day = day
        
        return calendar.dateFromComponents(components)!
    }
    
    func nextFirstDateOfMonth(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
            , fromDate: self)
        components.day = 1
        components.month = components.month + 1
        
        return calendar.dateFromComponents(components)!
    }
    
    func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: date, toDate: self, options: []).year
    }
    func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: date, toDate: self, options: []).month
    }
    func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    func daysFrom(date:NSDate) -> Int{
        
        let fromDay = date.beginningOfDay()
        let toDay = self.beginningOfDay()
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: fromDay, toDate: toDay, options: []).day
    }
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: date, toDate: self, options: []).hour
    }
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: date, toDate: self, options: []).minute
    }
    func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: date, toDate: self, options: []).second
    }
    func offsetFrom(date:NSDate) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
    
    var datePart:NSDate{
        return self.beginningOfDay()
    }
    
    func isTheSameDay(date:NSDate)->Bool{
        return self.beginningOfDay() == date.beginningOfDay()
    }
    
    func originalOfDay(calendar:NSCalendar! = NSCalendar.currentCalendar())->NSDate{
        let components = calendar.components(
            [.Year,.Month,.Day,.Hour,.Minute]
            , fromDate: self)
        return calendar.dateFromComponents(components)!
    }
    
    func isSameDate(date:NSDate)->Bool{
        return self.originalOfDay() == date.originalOfDay()
    }
    
    func getWeek()->(begin:NSDate,end:NSDate){
        
        let calendar = NSCalendar.currentCalendar()
        var startOfWeek: NSDate?
        var endOfWeek: NSDate!
        var interval = NSTimeInterval(0)
        
        calendar.rangeOfUnit(.WeekOfMonth, startDate: &startOfWeek, interval: &interval, forDate: NSDate())
        endOfWeek = startOfWeek!.dateByAddingTimeInterval(interval - 1)
        return (startOfWeek ?? self,endOfWeek ?? self)
    }
}

extension UIScrollView{
    
    var visibleRect:CGRect{
        
        var visibleRect = CGRectZero
        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size
        
        let theScale = 1.0 / self.zoomScale
        visibleRect.origin.x *= theScale
        visibleRect.origin.y *= theScale
        visibleRect.size.width *= theScale
        visibleRect.size.height *= theScale
        
        return visibleRect
    }
}

extension UIView {
    
    func addDashedLine(path:CGPath,color:UIColor = UIColor.blackColor(),lineWidth:CGFloat = 1, dashPattern:(Float,Float)=(5,5)){
        
        self.layer.sublayers?.filter({$0.name == "DashedLine"}).forEach({$0.removeFromSuperlayer()})
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedLine"
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = color.CGColor
        shapeLayer.lineWidth = lineWidth
        //        shapeLayer.lineCap = kCALineCapRound
        //        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [dashPattern.0,dashPattern.1]
        shapeLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func removeDashedLine(){
        self.layer.sublayers?.filter({$0.name == "DashedLine"}).forEach({$0.removeFromSuperlayer()})
    }
}

extension UIColor{
    /**
     傳入16進位，轉換成顏色
     
     - parameter rgbValue: 16進位RGB
     - parameter alpha:    透明度
     
     - returns: ios可使用的color
     */
    convenience init(hex:UInt,alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha)
    }
}

