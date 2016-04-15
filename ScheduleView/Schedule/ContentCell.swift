//
//  CourseCell.swift
//  scheduleView
//
//  Created by hjliu on 2016/3/29.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
//        //畫虛線
//        let cellWidth = Float(self.contentView.frame.width)
//        let dashPattern = (cellWidth/10 , cellWidth/10)
//        
//        let lineWidth:CGFloat = 2
//        let y = contentView.frame.maxY - lineWidth/2
//        
//        let bottomPath = UIBezierPath()
//        bottomPath.moveToPoint(CGPoint(x: contentView.frame.minX, y: y))
//        bottomPath.addLineToPoint(CGPoint(x: contentView.frame.maxX, y: y))
//        
//        contentView.addDashedLine(bottomPath.CGPath, color: UIColor.grayColor(),lineWidth: lineWidth,dashPattern: dashPattern)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func setData(rowIndex:Int,data:Schedule?){
        
        //設定底色
        if rowIndex % 2 > 0{
            self.contentView.backgroundColor = Configuration.ColorSet.color1
        }else{
            self.contentView.backgroundColor = Configuration.ColorSet.color19
        }
        
        //有課程
        if let data = data{
            
            //製作課程畫面
            
            let rect = CGRectMake(
                self.contentView.frame.origin.x + 2,
                self.contentView.frame.origin.y - self.contentView.frame.height * CGFloat(data.spanCount - 1),
                self.contentView.frame.width - 4, //左右寬間隔2*2
                self.contentView.frame.height * CGFloat(data.spanCount)
            )
            let subView = ScheduleInfoView(frame: rect)
            subView.setData(data)
            contentView.addSubview(subView)
        }
    }
}