//
//  ScheduleVC.swift
//  scheduleView
//
//  Created by hjliu on 2016/3/31.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

protocol ScheduleViewDelegate {
    //取得水平header文字
    func arrayDataForTopHeader()->[AnyObject]
    
    //取得垂直header文字
    func arrayDataForLeftHeader()->[AnyObject]
    
    func arrayDataForContent()->[Schedule]
}

//DATA
class Schedule{
    var startIndex:Int
    var spanCount:Int = 1 //佔幾格
    var title:String
    var content:String
    var backgroundColor:UIColor
    var viewEvent:()->()
    
    init(startIndex:Int,spanCount:Int = 1,title:String,content:String,backgroundColor:UIColor,viewEvent:()->()){
        self.startIndex = startIndex
        self.spanCount = spanCount
        self.title = title
        self.content = content
        self.backgroundColor = backgroundColor
        self.viewEvent = viewEvent
    }
}


class ScheduleView: UIView,UICollectionViewDataSource,UICollectionViewDelegate{

    /// UI
    private var topCollectionView:UICollectionView!
    private var leftCollectionView:UICollectionView!
    private var contentCollectionView:UICollectionView!
    private var baseScrollView = UIScrollView()
    
    /// SETTING
    var topItemWidth:CGFloat{
        return ceil((self.frame.width - leftItemWidth) / 5)
    }
    
    var topItemHeight:CGFloat = 48
    var leftItemWidth:CGFloat = 45
    var leftItemHeight:CGFloat = 72
    
    /// DATA
    var delegate:ScheduleViewDelegate?
    
    private var topDatas:[AnyObject]{
        return delegate?.arrayDataForTopHeader() ?? []
    }
    
    private var leftDatas:[AnyObject]{
        return delegate?.arrayDataForLeftHeader() ?? []
    }
    
    private var contentDatas:[Schedule]{
        return delegate?.arrayDataForContent() ?? []
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView(){
        
        self.backgroundColor = Configuration.ColorSet.color10
        
        //上
        let topLayout = BaseLayout()
        topLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        topCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: topLayout)
        topCollectionView.bounces = false
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        topCollectionView.backgroundColor = UIColor.clearColor()
        topCollectionView.registerClass(TopTitleCell.self, forCellWithReuseIdentifier: "TopTitleCell")
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topCollectionView)
        
        //左
        let leftLayout = BaseLayout()
        leftLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        leftCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: leftLayout)
        leftCollectionView.bounces = false
        leftCollectionView.dataSource = self
        leftCollectionView.delegate = self
        leftCollectionView.backgroundColor = UIColor.clearColor()
        leftCollectionView.registerClass(LeftTitleCell.self, forCellWithReuseIdentifier: "LeftTitleCell")
        leftCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftCollectionView)
        
        //中
        baseScrollView.bounces = false
        baseScrollView.delegate = self
        baseScrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(baseScrollView)
        
        let contentLayout = ContentLayout()
        contentLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        contentCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: contentLayout)
        contentCollectionView.bounces = false
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.registerClass(ContentCell.self, forCellWithReuseIdentifier: "ContentCell")
        contentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        baseScrollView.addSubview(contentCollectionView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()

        let viewsDict = [
            "topCollectionView":topCollectionView,
            "leftCollectionView":leftCollectionView,
            "baseScrollView": baseScrollView,
            "contentCollectionView" : contentCollectionView,
            ] as [String:AnyObject]
        
        let metrics = [
            "topItemHeight":topItemHeight,
            "leftItemWidth":leftItemWidth,
        ]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftItemWidth-[topCollectionView]|", options: [], metrics: metrics, views: viewsDict))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[leftCollectionView(leftItemWidth)][baseScrollView]|", options: [], metrics: metrics, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-topItemHeight-[leftCollectionView]|", options: [], metrics: metrics, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[topCollectionView(topItemHeight)][baseScrollView]|", options: [], metrics: metrics, views: viewsDict))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //左側欄位數
        let leftHeaderCount = delegate?.arrayDataForLeftHeader().count ?? 0
        
        let newSize = CGSize(width: self.frame.width - leftItemWidth, height: leftItemHeight*CGFloat(leftHeaderCount))
        
        //設定contentCollectionView Size
        contentCollectionView.frame.size = newSize
        baseScrollView.contentSize = newSize
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        //週
        if collectionView == topCollectionView{
            return topDatas.count
        }
        
        //時間
        if collectionView == leftCollectionView{
            return leftDatas.count
        }
        
        //課表
        return topDatas.count * leftDatas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        if collectionView == topCollectionView{
            
            //top標頭
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TopTitleCell", forIndexPath: indexPath) as! TopTitleCell
            
            cell.setData(topDatas[indexPath.row] as! String)
            
            cell.updateConstraintsIfNeeded()
            return cell
        }
        
        if collectionView == leftCollectionView{
            //left標頭
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LeftTitleCell", forIndexPath: indexPath) as! LeftTitleCell
            
            let data = leftDatas[indexPath.row] as! NSDate
            cell.setData("\(indexPath.row + 1)",contentText: data.to_HM_String())
            
            cell.updateConstraintsIfNeeded()
            return cell
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContentCell", forIndexPath: indexPath) as! ContentCell
        
        let currentIndex = indexPath.row + 1
        
        let data = contentDatas.filter({ d in
            d.startIndex + d.spanCount - 1 == currentIndex
        }).first
        
        cell.setData(currentIndex%leftDatas.count , data: data)
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    //設定cell大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        if collectionView == topCollectionView{
            return CGSizeMake(topItemWidth, topItemHeight)
        }
        if collectionView == leftCollectionView{
            return CGSizeMake(leftItemWidth, leftItemHeight)
        }
        return CGSizeMake(topItemWidth, leftItemHeight)
    }
    
     /// view的連動
    
    var currentDraggingScrollView:UIScrollView?
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        currentDraggingScrollView = scrollView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        
        if currentDraggingScrollView != scrollView{
            return
        }
        
        switch scrollView {
        case topCollectionView:
            contentCollectionView.contentOffset = scrollView.contentOffset
        case leftCollectionView:
            contentCollectionView.contentOffset = scrollView.contentOffset
        case contentCollectionView:
            topCollectionView.contentOffset = scrollView.contentOffset
        case baseScrollView:
            leftCollectionView.contentOffset = scrollView.contentOffset
        default: break
        }
    }
}

