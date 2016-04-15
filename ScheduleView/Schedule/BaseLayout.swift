//
//  baseLayout.swift
//  scheduleView
//
//  Created by hjliu on 2016/3/31.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class BaseLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
