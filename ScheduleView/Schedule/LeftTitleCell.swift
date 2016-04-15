//
//  TimeTitleCell.swift
//  scheduleView
//
//  Created by hjliu on 2016/3/31.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class LeftTitleCell: UICollectionViewCell {

    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textColor = Configuration.ColorSet.color8
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        contentLabel.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        contentLabel.font = UIFont.systemFontOfSize(12)
        contentLabel.textColor = Configuration.ColorSet.color9_5
        contentLabel.textAlignment = NSTextAlignment.Center
        contentLabel.backgroundColor = UIColor.clearColor()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentLabel)
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
            "contentLabel" : contentLabel,
            ] as [String:AnyObject]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[titleLabel]|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentLabel]|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[titleLabel]-[contentLabel]-(>=0)-|", options: [], metrics: nil, views: views))
    }
    
    func setData(titleText:String,contentText:String){
        self.titleLabel.text = titleText
        self.contentLabel.text = contentText
    }
}
