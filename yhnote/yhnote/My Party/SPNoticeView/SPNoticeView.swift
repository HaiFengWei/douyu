//
//  SPNoticeView.swift
//  SPNoticeViewDemo
//
//  Created by 韦海峰 on 2018/11/12.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

let sp_noticeViewLabelMargin : CGFloat = 30.0
let sp_noticeViewBottomMargin : CGFloat = 30.0 + sp_tabbarSafeBottomMargin
let sp_noticeViewLabel_BgLeftAndRightMargin : CGFloat = 15.0
let sp_noticeViewLabel_BgTopAndBottomMargin : CGFloat = 5.0
let sp_noticeViewScreenW : CGFloat = UIScreen.main.bounds.width
let sp_noticeViewScreenH : CGFloat = UIScreen.main.bounds.height

let sp_noticeViewLabelFont : UIFont = UIFont.systemFont(ofSize: 16)

class SPNoticeView: UIView {
    
    // MARK: - private vaule
    private var showTime : Double = 1.5
    private var alphaAnimationDuration : Double = 0.2
    @objc  var noticeTitle : NSString = ""
    
    // MARK: - Lazyload
    private var noticeLabel : UILabel = {
        let noticeLabel = UILabel()
        noticeLabel.textColor = UIColor.white
        noticeLabel.numberOfLines = 0
        noticeLabel.textAlignment = NSTextAlignment.center
        noticeLabel.font = sp_noticeViewLabelFont
        return noticeLabel
    }()
    
    @objc init(noticeTitle: NSString, showTime : Double) {
        self.noticeTitle = noticeTitle
        self.showTime = showTime
        
        super.init(frame:CGRect.zero)
        self.backgroundColor = UIColor.init(white: 0.1, alpha: 0.9)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SPNoticeView控件已释放")
    }
    
}

// MARK: -
// MARK: - Public Method
extension SPNoticeView {
    @objc func show() {
        self.removeFromSuperview()
        
        let currentWindow = UIApplication.shared.keyWindow
        currentWindow?.addSubview(self)
        self.noticeLabel.text = noticeTitle as String
        noticeLabel.sizeToFit()
        self.addSubview(noticeLabel)
        self.layer.cornerRadius = sp_noticeViewLabel_BgLeftAndRightMargin
        self.clipsToBounds = true
        
        var noticeViewW : CGFloat = 0.0
        var noticeViewH : CGFloat = 0.0
        var noticeViewX : CGFloat = 0.0
        var noticeViewY : CGFloat = 0.0
        
        var noticeLabelH : CGFloat = 0.0
        var noticeLabelW : CGFloat = 0.0
        
        if noticeLabel.frame.width >= (sp_noticeViewScreenW - sp_noticeViewLabelMargin*2.0)
        {
            noticeLabelH = getLabelSize().height
            noticeLabelW = sp_noticeViewScreenW - sp_noticeViewLabelMargin*2.0
            noticeViewH = noticeLabelH + sp_noticeViewLabel_BgTopAndBottomMargin*2.0
            noticeViewW = noticeLabelW + sp_noticeViewLabel_BgLeftAndRightMargin*2.0
            noticeViewX = (sp_noticeViewScreenW - noticeViewW)/2.0
            noticeViewY = sp_noticeViewScreenH  - noticeViewH - sp_noticeViewBottomMargin
        }
        else
        {
            noticeLabelH = noticeLabel.frame.height
            noticeLabelW = noticeLabel.frame.width;
            noticeViewH = noticeLabelH + sp_noticeViewLabel_BgTopAndBottomMargin*2.0
            noticeViewW = noticeLabelW + sp_noticeViewLabel_BgLeftAndRightMargin*2.0
            noticeViewX = (sp_noticeViewScreenW - noticeViewW)/2.0
            noticeViewY = sp_noticeViewScreenH  - noticeViewH - sp_noticeViewBottomMargin
        }
        
        // 设置self frame
        self.frame = CGRect(x: noticeViewX, y: noticeViewY, width: noticeViewW, height: noticeViewH);
        // 设置noticeLabel frame
        noticeLabel.frame = CGRect(x: sp_noticeViewLabel_BgLeftAndRightMargin, y: sp_noticeViewLabel_BgTopAndBottomMargin, width: noticeLabelW, height: noticeLabelH)
        
        if showTime < alphaAnimationDuration*2.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.showTime) { [weak self] in
                self?.removeFromSuperview()
                self = nil;
            }
            
        }
        else
        {
            self.alpha = 0.01
            
            
            let delayTime = showTime - alphaAnimationDuration*2.0
            
            UIView.animate(withDuration: alphaAnimationDuration) { [weak self] in
                self?.alpha = 1.0;
            }
            
            UIView.animate(withDuration: alphaAnimationDuration, delay: delayTime, options: UIView.AnimationOptions.layoutSubviews, animations: { [weak self] in
                self?.alpha = 0.01;
            }) { [weak self] (isCompletion) in
                self?.removeFromSuperview()
                self = nil;
            }
        }
        
        
    }
}

// MARK: - private Method
extension SPNoticeView {
    func getLabelSize() -> (CGSize) {
        
        let size = CGSize(width: UIScreen.main.bounds.width - sp_noticeViewLabelMargin*2.0, height: 900)
        let dic = NSDictionary(object: sp_noticeViewLabelFont, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = noticeTitle.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize
    }
}
