//
//  SPtabbarContentView.swift
//  SPTabbarDemo
//
//  Created by 韦海峰 on 2018/11/9.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

private let collectionCellId = "spTabbarContentCollectionCellId"

@objc protocol SPtabbarContentViewDelegate : class {
    @objc optional func sptabbarContentView(progress:CGFloat, targetIndex:Int, sourceIndex:Int)
    
     @objc optional func sptabbarEndScroll(targetIndex:Int)
}

class SPtabbarContentView: UIView {
    
    // MARK: - 公共属性
    weak var delegate : SPtabbarContentViewDelegate?
    var viewControllers : [UIViewController] =  [UIViewController]() {
        didSet {
            setupUI()
        }
    }
    
    // MARK: - 私有属性
    // item数组
   
    private weak var parentController : SPTabbarController?
    private(set) var currentIndex : Int = 0
    private var lastContentOffsetX : CGFloat = 0.0
    
    // MARK: - 懒加载
    private lazy var collectionView : UICollectionView = { [weak self] in
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.itemSize = (self?.frame.size)!
        layout.scrollDirection = .horizontal
        
        let collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
        return collectionView
    }()
    
    
    init(frame: CGRect, parentController:SPTabbarController) {
//        self.viewControllers = viewControllers
        self.parentController = parentController
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 创建UI
extension SPtabbarContentView {
    func setupUI() {
        // 设置视图管理器自己管理自己视图
        for childVc in viewControllers {
            parentController?.addChild(childVc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SPtabbarContentView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath)
        let childVc = viewControllers[indexPath.item]
        childVc.view.frame = self.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        delegate?.sptabbarEndScroll?(targetIndex: Int(page))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 如果不是手势拖动导致的此方法被调用，不处理
        if (!(scrollView.isDragging || scrollView.isDecelerating)) {
            return
        }
        
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        
        let index = Int(currentOffsetX/bounds.width)

        if (currentOffsetX > lastContentOffsetX) {
            // 左滑
            progress = currentOffsetX/bounds.width - floor(currentOffsetX/bounds.width)
            
            sourceIndex = index
            targetIndex = index + 1
            if (targetIndex >= viewControllers.count) {
                targetIndex = viewControllers.count - 1
            }
            
        } else {
            progress = 1 - (currentOffsetX/bounds.width - floor(currentOffsetX/bounds.width))
            // 右滑
            targetIndex = index
            sourceIndex = index + 1
            if (sourceIndex >= viewControllers.count) {
                sourceIndex = viewControllers.count - 1
            }
        }
        
        
//        if targetIndex == Int((currentOffsetX/bounds.width)) {
//            progress = 1.0
//        }
        
        lastContentOffsetX = currentOffsetX
        
        delegate?.sptabbarContentView?(progress: progress, targetIndex: targetIndex, sourceIndex: sourceIndex)
    }
 
}


// MARK: - 外部调用方法
extension SPtabbarContentView {
    func setCurrentIndex(currentIndex:Int) {
        self.currentIndex = currentIndex
        let offsetPointX = CGFloat(currentIndex)*bounds.width
        collectionView.contentOffset = CGPoint(x: offsetPointX, y: 0)
    }
}
