//
//  SPtabbar.swift
//  SPTabbarDemo
//
//  Created by 韦海峰 on 2018/11/9.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit


// MARK: - 常量属性

/// 底部分割线高度
let sp_kBottomLineH : CGFloat = 1.0
/// 底部滑块高度
let sp_kProgressLineH : CGFloat = 1.0

@objc protocol SPtabbarDelegate : class {
    @objc optional func sptabbar(didSelectedIndex:Int)
}

/// 系统方法
class SPtabbar: UIView {
    // MARK: - 公共属性
    weak var delegate : SPtabbarDelegate?
    var titles : [NSString] = [NSString]() {
        didSet{
            setupUI()
        }
    }
    var itemSpace : CGFloat = 15.0
    
    
    // MARK: - 私有属性
    // item数组
    private var items : [SPTabbarItem] =  [SPTabbarItem]()
    private(set) var currentIndex : Int = 0
    
    // MARK: - 懒加载
    // scrollView
    lazy private var scrollView : UIScrollView = { [weak self] in
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = self?.bounds ?? CGRect.zero
        return scrollView
        }()
    
    lazy private var progressLine : UIView = { [weak self] in
        let progressLine = UIView()
        progressLine.backgroundColor = UIColor.orange
        return progressLine
    }()
    
    

    
    /// 自定义构造函数
    ///
    /// - Parameters:
    ///   - frame:  位置尺寸
    ///   - titles: 标题数组
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -
// MARK: - 创建UI
extension SPtabbar {

    private func setupUI() {
        // 添加scrollViwe
        addSubview(scrollView)
        // 添加底部滑块
        scrollView.addSubview(progressLine)
        // 创建标题item
        creatTitleItems()
        // 设置scrollView 内容视图尺寸
        setScrollViewContentFrame()

    }
    
    
    /// 创建items
    private func creatTitleItems() {
        
        var itemW = 0.0
        let itemH = bounds.height - sp_kBottomLineH
        var itemX : CGFloat = 0.0
        let itemY : CGFloat = 0.0
        
        for (index, vaule) in titles.enumerated() {
            
            let item : SPTabbarItem  = SPTabbarItem()
            item.setTitle(vaule as String, for: UIControl.State.normal)
            item.sizeToFit()
            itemW = Double(item.frame.width + itemSpace*2.0)

            item.frame = CGRect(x: itemX, y: itemY, width: CGFloat(itemW), height: itemH)
            item.addTarget(self, action:  #selector(itemClick(item:)), for: UIControl.Event.touchUpInside)
            item.tag = index
            scrollView.addSubview(item)
            if (index == 0) {
                
                let progressLineW = item.frame.width/2.0
                
                
                item.setTitleColor(UIColor.orange, for: UIControl.State.normal)
                progressLine.frame = CGRect(x: item.frame.origin.x + (item.frame.width - progressLineW)/2.0, y: bounds.size.height - sp_kProgressLineH, width: progressLineW, height: sp_kProgressLineH)
            } else {
                item.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            }
            itemX = itemX + item.frame.width
            items.append(item)
        }
    }
    
    private  func setScrollViewContentFrame() {
        if let lastItem = items.last {
            let scrollViewW = lastItem.frame.origin.x +  lastItem.frame.width + itemSpace
            let scrollViewH = bounds.height
            scrollView.contentSize = CGSize(width: scrollViewW, height: scrollViewH)
        }
       
    }
    
    
}

// MARK: -
// MARK: - 事件点击
extension SPtabbar {
    
    
    @objc private func itemClick(item : SPTabbarItem) {
        let oldItem = items[currentIndex]
        if oldItem == item { return }
        
        item.setTitleColor(UIColor.orange, for: UIControl.State.normal)
        oldItem.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        
        currentIndex = item.tag
        let progressLineW = progressLine.frame.width
        let progressLineX = item.frame.origin.x + (item.frame.width - progressLineW)/2.0
        
        
        let centenrX = progressLineX + progressLineW/2.0
        var offsetPoint : CGPoint = CGPoint.zero
        let contentW    = scrollView.contentSize.width
        let scrollViewW = scrollView.frame.width
        
        if (contentW <= scrollViewW) {
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.progressLine.frame = CGRect(x: progressLineX, y: (self?.bounds.size.height ?? 0) - sp_kProgressLineH, width: progressLineW, height: sp_kProgressLineH)
                self?.scrollView.contentOffset = offsetPoint
            }
        } else if (centenrX <= scrollViewW/2.0) {
            
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.progressLine.frame = CGRect(x: progressLineX, y: (self?.bounds.size.height ?? 0) - sp_kProgressLineH, width: progressLineW, height: sp_kProgressLineH)
                self?.scrollView.contentOffset = offsetPoint
            }
        } else if ((centenrX > scrollViewW/2.0) && ((centenrX + scrollViewW/2.0) > contentW)) {
            offsetPoint = CGPoint(x: contentW - scrollViewW, y: 0)
            
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.progressLine.frame = CGRect(x: progressLineX, y: (self?.bounds.size.height ?? 0) - sp_kProgressLineH, width: progressLineW, height: sp_kProgressLineH)
                self?.scrollView.contentOffset = offsetPoint
            }
            
        } else {
            offsetPoint = CGPoint(x: centenrX - scrollViewW/2.0, y: 0)
            
            self.progressLine.frame = CGRect(x: progressLineX, y: (self.bounds.size.height) - sp_kProgressLineH, width: progressLineW, height: sp_kProgressLineH)
            
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.scrollView.contentOffset = offsetPoint
            }
        }
        
        delegate?.sptabbar?(didSelectedIndex: currentIndex)
    }
}

// MARK: -
// MARK: - 对外暴露公共方法
extension SPtabbar {
    
    func setSelectItemIndex(selectedIndex:Int) {
        let selectItem = items[selectedIndex]
        itemClick(item: selectItem)
        print("itemClick")
    }
    
    
    func setTbbarChange(progress:CGFloat, targetIndex:Int, sourceIndex:Int){
        var normalRed : CGFloat = 0.0
        var normalGreen : CGFloat = 0.0
        var normalBlue : CGFloat = 0.0
        var normalAlpha : CGFloat = 0.0
        
        var selectedRed : CGFloat = 0.0
        var selectedGreen : CGFloat = 0.0
        var selectedBlue : CGFloat = 0.0
        var selectedAlpha : CGFloat = 0.0
        
        let sourceItem : SPTabbarItem = items[sourceIndex]
        let targetItem : SPTabbarItem = items[targetIndex]
        
        
        UIColor.orange.getRed(&selectedRed, green: &selectedGreen, blue: &selectedBlue, alpha: &selectedAlpha)
        UIColor.gray.getRed(&normalRed, green: &normalGreen, blue: &normalBlue, alpha: &normalAlpha)
   
        
        // 获取选中和未选中状态的颜色差值
        let redDiff = selectedRed - normalRed;
        let greenDiff = selectedGreen - normalGreen;
        let blueDiff = selectedBlue - normalBlue;
        let alphaDiff = selectedAlpha - normalAlpha;
        
        // 根据颜色值的差值和偏移量，设置tabItem的标题颜色
        sourceItem.setTitleColor(UIColor(red: selectedRed - progress * redDiff,
                                         green: selectedGreen - progress * greenDiff,
                                         blue: selectedBlue - progress * blueDiff,
                                         alpha: selectedAlpha - progress * alphaDiff),
                                 for: UIControl.State.normal)
        
        targetItem.setTitleColor(UIColor(red: normalRed + progress * redDiff,
                                         green: normalGreen + progress * greenDiff,
                                         blue: normalBlue + progress * blueDiff,
                                         alpha: normalAlpha + progress * alphaDiff),
                                 for: UIControl.State.normal)
        
        
        // 
        let progressLineW = progressLine.frame.width
        let progressLineX = sourceItem.frame.origin.x + (sourceItem.frame.width - progressLineW)/2.0
        
        let moveTotalX = (targetItem.frame.origin.x + targetItem.frame.width/2.0) - (sourceItem.frame.origin.x + sourceItem.frame.width/2.0)
        let movex = moveTotalX * progress
        progressLine.frame.origin.x = progressLineX + movex
    }
}
