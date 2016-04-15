//
//  ScheduleInfoView.swift
//  scheduleView
//
//  Created by hjliu on 2016/4/1.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class ScheduleInfoView: UIControl {

    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textColor = Configuration.ColorSet.color1
        titleLabel.highlightedTextColor = UIColor.darkTextColor()
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        subTitleLabel.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        subTitleLabel.font = UIFont.systemFontOfSize(12)
        subTitleLabel.textColor = Configuration.ColorSet.color9_5
        subTitleLabel.highlightedTextColor = UIColor.darkTextColor()
        subTitleLabel.textAlignment = NSTextAlignment.Left
        subTitleLabel.numberOfLines = 1
        subTitleLabel.backgroundColor = UIColor.clearColor()
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subTitleLabel)
        
        let views = [
            "titleLabel" : titleLabel,
            "subTitleLabel" : subTitleLabel,
        ] as [String:AnyObject]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-4-[titleLabel]-4-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-4-[subTitleLabel]-4-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[titleLabel]-8-[subTitleLabel]-(>=8)-|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data:Schedule){
        titleLabel.text = data.title
        subTitleLabel.text = data.content
        self.backgroundColor = data.backgroundColor
    }
}

//class PaddingLabel: UILabel {
//    
//    let padding = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
//    
//    override func drawTextInRect(rect: CGRect) {
//        let newRect = UIEdgeInsetsInsetRect(rect, padding)
//        super.drawTextInRect(newRect)
//    }
//    
//    override func intrinsicContentSize() -> CGSize {
//        var intrinsicContentSize = super.intrinsicContentSize()
//        intrinsicContentSize.height += padding.top + padding.bottom
//        intrinsicContentSize.width += padding.left + padding.right
//        return intrinsicContentSize
//    }
//}

