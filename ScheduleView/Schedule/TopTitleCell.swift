//
//  WeekTitleCell.swift
//  scheduleView
//
//  Created by hjliu on 2016/4/1.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class TopTitleCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textColor = Configuration.ColorSet.color8
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let views = [
            "super":contentView,
            "titleLabel" : titleLabel,
            ] as [String:AnyObject]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[titleLabel]|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[titleLabel]|", options: [], metrics: nil, views: views))
    }
    
    func setData(text:String){
        self.titleLabel.text = text
    }
}
