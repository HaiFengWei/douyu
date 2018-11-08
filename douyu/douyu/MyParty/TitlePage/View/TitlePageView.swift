//
//  TitlePageView.swift
//  douyu
//
//  Created by 韦海峰 on 2018/11/5.
//  Copyright © 2018年 sepeak. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2.0
private let kNormalColor : (CGFloat, CGFloat,CGFloat) = (85,85,85)
private let kselectedColor : (CGFloat, CGFloat,CGFloat) = (255,128,85)

protocol TitlePageViewDelegate : class {
    func titlePageView(titleView:TitlePageView, selectedIndex index:Int)
}

class TitlePageView: UIView {

    /// 标题数组
    private var titles : [String]
    
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    var currentIndex = 0
    weak var delegate : TitlePageViewDelegate?
    
    
    
    
    
    // MARK:- 懒加载
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView(frame: CGRect(x: 0, y: frame.height - kScrollLineH, width: kScreenWidth/4.0, height: kScrollLineH))
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
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
        
        setBottomLine()
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
            if (index == 0) {
                label.textColor = UIColor(r: kselectedColor.0, g: kselectedColor.1, b: kselectedColor.2)
            } else {
                label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            }
            label.tag = index
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClicl(tap:)))
            tap.numberOfTapsRequired = 1
            label.addGestureRecognizer(tap)
            label.isUserInteractionEnabled = true
            titleLabels.append(label)
            scrollView.addSubview(label)
        
        }
    }
    
    private func setBottomLine() {
        let bottomLine = UIView(frame: CGRect(x: 0, y: frame.height - 0.5, width: kScreenWidth, height: 0.5))
        bottomLine.backgroundColor = UIColor.black
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        
        scrollView.addSubview(scrollLine);
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}


// MARK: - 事件点击
extension TitlePageView {
    @objc private func titleLabelClicl(tap:UITapGestureRecognizer) {
        let currentLabel = tap.view as! UILabel
        currentLabel.textColor = UIColor.orange
        
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor.gray
        
        currentIndex = currentLabel.tag
        
        let scollLineX = currentLabel.frame.origin.x
        UIView.animate(withDuration: 0.15) {[weak self] in
            self?.scrollLine.frame.origin.x = scollLineX
        }
        
        delegate?.titlePageView(titleView: self, selectedIndex: currentIndex)
    }
}

extension TitlePageView {
    func settitleWithPtogress(progress:CGFloat, sourceIndex:Int, targetIndex:Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let movex = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + movex
        
        let colorDelta = (kselectedColor.0-kNormalColor.0,kselectedColor.1-kNormalColor.1,kselectedColor.2-kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kselectedColor.0 - colorDelta.0*progress, g: kselectedColor.1 - colorDelta.1*progress, b: kselectedColor.2 - colorDelta.2*progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g:  kNormalColor.1 + colorDelta.1 * progress, b:  kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
