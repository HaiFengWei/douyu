//
//  TitlePageView.swift
//  douyu
//
//  Created by 韦海峰 on 2018/11/5.
//  Copyright © 2018年 sepeak. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2.0

class TitlePageView: UIView {

    /// 标题数组
    private var titles : [String]
    
    // MARK:- 懒加载
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    /// 自定义构造函数
    ///
    /// - Parameters:
    ///   - frame:  尺寸
    ///   - titles: 标题数组
    init(frame: CGRect, titles : [String]) {
        
        self.titles = titles;
        
        super.init(frame: frame)
        
        setupUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI界面
extension TitlePageView {
    private func setupUi() {
        // 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加标题
        setTitleLabels()
    }
    
    
    /// 创建标题
    private func setTitleLabels()  {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label  = UILabel();
            label.text = title;
            label.tag  = index;
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
        }
    }
    
    private func setBottomLine() {
        // let
    }
}
