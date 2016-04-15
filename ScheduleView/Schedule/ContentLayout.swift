//
//  CLayout.swift
//  scheduleView
//
//  Created by hjliu on 2016/3/29.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class ContentLayout: BaseLayout {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        //範圍內所有物件
        guard let superAttributes = super.layoutAttributesForElementsInRect(rect) else{ return nil }
        
        for layoutAttributes in superAttributes {
            
            //如果是cell
            if (layoutAttributes.representedElementCategory == .Cell) {
                
                layoutAttributes.zIndex = layoutAttributes.indexPath.row
            }
        }
        
        return superAttributes
    }
    
    /**
     返回true只要顯示的邊界發生改變就重新布局:(預設是false)
     内部會重新調用prepareLayout和調用
     layoutAttributesForElementsInRect方法獲得部分cell的布局屬性
     */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}

//class CLayout: UICollectionViewFlowLayout {
//
//    var rowOfNumber = 7
//    
//    override init() {
//        super.init()
//        
//        scrollDirection = UICollectionViewScrollDirection.Horizontal
//        minimumLineSpacing = 0
//        minimumInteritemSpacing = 0
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        
//        //範圍內所有物件
//        let superAttributes = NSMutableArray(array: super.layoutAttributesForElementsInRect(rect) ?? [])
//        
//        for layoutAttributes in superAttributes {
//            
//            //如果是cell
//            if (layoutAttributes.representedElementCategory == .Cell) {
//                
//                //移除第一橫排
//                if layoutAttributes.indexPath.row < rowOfNumber{
//
//                    superAttributes.removeObject(layoutAttributes)
//                }
//                
//                //移除最左直排
//                if layoutAttributes.indexPath.row % rowOfNumber == 0{
//
//                    superAttributes.removeObject(layoutAttributes)
//                }
//            }
//        }
//        
//        //加入新的Attributes
//        superAttributes.addObjectsFromArray( freezeCommentsAttributes(rowOfNumber) )
//        
//        return superAttributes.map({$0 as! UICollectionViewLayoutAttributes})
//    }
//    
//    /**
//     返回true只要顯示的邊界發生改變就重新布局:(預設是false)
//     内部會重新調用prepareLayout和調用
//     layoutAttributesForElementsInRect方法獲得部分cell的布局屬性
//     */
//    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
//        return true
//    }
//    
//    func getAttributes(index:NSIndexPath)->UICollectionViewLayoutAttributes?{
//        return layoutAttributesForItemAtIndexPath(index)
//    }
//    
//    func freezeCommentsAttributes(rowCount:Int)->[UICollectionViewLayoutAttributes]{
//        
//        let contentOffset = collectionView!.contentOffset //位移量
//        let scrollView = collectionView!.superview as! UIScrollView
//        
//        let output = NSMutableSet()
//        
//        //左上角cell
//        if let layoutAttributes = getAttributes(NSIndexPath(forRow: 0, inSection: 0)){
//            layoutAttributes.zIndex = 1025
//            layoutAttributes.frame.origin = CGPoint(x: scrollView.contentOffset.x, y: contentOffset.y)
//            output.addObject(layoutAttributes)
//        }
//
//        //第一橫排
//        for i in 1..<rowCount{
//            
//            if let layoutAttributes = getAttributes(NSIndexPath(forRow: i, inSection: 0)){
//                layoutAttributes.zIndex = 1024
//                layoutAttributes.frame.origin = CGPoint(x: CGFloat(i) * layoutAttributes.frame.size.width, y: contentOffset.y)
//                output.addObject(layoutAttributes)
//            }
//        }
//        
//        //第一直排
//        for i in rowCount.stride(to: collectionView!.numberOfItemsInSection(0), by: +rowCount ) {
//            
//            if let layoutAttributes = getAttributes(NSIndexPath(forRow: i, inSection: 0)){
//                layoutAttributes.zIndex = 1024
//                layoutAttributes.frame.origin = CGPoint(x: scrollView.contentOffset.x, y: CGFloat(i/rowCount) * layoutAttributes.frame.size.height)
//                output.addObject(layoutAttributes)
//            }
//        }
//        
//        return output.allObjects as! [UICollectionViewLayoutAttributes]
//    }
//}



//class CLayout: UICollectionViewFlowLayout {
//    
//    override init() {
//        super.init()
//        
//        minimumLineSpacing = 0
//        minimumInteritemSpacing = 0
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        
//        //範圍內所有cell
//        let superAttributes:NSMutableArray = NSMutableArray(array: super.layoutAttributesForElementsInRect(rect)!) as NSMutableArray
//        
//        let contentOffset = collectionView!.contentOffset
//        let missingSections = NSMutableIndexSet()
//        
//        for layoutAttributes in superAttributes {
//            if (layoutAttributes.representedElementCategory == .Cell) {
//                missingSections.addIndex(layoutAttributes.indexPath.section)
//            }
//        }
//        
//        for layoutAttributes in superAttributes{
//            if let representedElementKind = layoutAttributes.representedElementKind {
//                if representedElementKind == UICollectionElementKindSectionHeader {
//                    missingSections.removeIndex(layoutAttributes.indexPath.section)
//                }
//            }
//        }
//        
//        missingSections.enumerateIndexesUsingBlock { idx, stop in
//            let indexPath = NSIndexPath(forItem: 0, inSection: idx)
//            let layoutAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath)
//            superAttributes.addObject(layoutAttributes!)
//        }
//        
//        for la in superAttributes {
//            
//            let layoutAttributes = la as! UICollectionViewLayoutAttributes
//            
//            if let representedElementKind = layoutAttributes.representedElementKind {
//                if representedElementKind == UICollectionElementKindSectionHeader {
//                    
//                    let section = layoutAttributes.indexPath.section
//                    let numberOfItemsInSection = collectionView!.numberOfItemsInSection(section)
//                    
//                    let firstCellIndexPath = NSIndexPath(forItem: 0, inSection: section)
//                    let lastCellIndexPath = NSIndexPath(forItem: max(0, (numberOfItemsInSection - 1)), inSection: section)
//                    
//                    var firstCellAttributes:UICollectionViewLayoutAttributes
//                    var lastCellAttributes:UICollectionViewLayoutAttributes
//                    
//                    if (self.collectionView!.numberOfItemsInSection(section) > 0) {
//                        firstCellAttributes = self.layoutAttributesForItemAtIndexPath(firstCellIndexPath)!
//                        lastCellAttributes = self.layoutAttributesForItemAtIndexPath(lastCellIndexPath)!
//                    } else {
//                        firstCellAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: firstCellIndexPath)!
//                        lastCellAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionFooter, atIndexPath: lastCellIndexPath)!
//                    }
//                    
//                    let headerHeight = CGRectGetHeight(layoutAttributes.frame)
//                    var origin = layoutAttributes.frame.origin
//                    
//                    origin.y = min(max(contentOffset.y, (CGRectGetMinY(firstCellAttributes.frame) - headerHeight)), (CGRectGetMaxY(lastCellAttributes.frame) - headerHeight))
//                    
//                    layoutAttributes.zIndex = 1024
//                    layoutAttributes.frame = CGRect(origin: origin, size: layoutAttributes.frame.size)
//                    
//                }
//            }
//        }
//        
//        return NSArray(array: superAttributes) as? [UICollectionViewLayoutAttributes]
//    }
//    
//    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
//        return true
//    }
//}
