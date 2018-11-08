//
//  ContentPageView.swift
//  douyu
//
//  Created by 韦海峰 on 2018/11/8.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

private let collectionCellId = "collectionCellId"

protocol ContentPageViewDelegate : class {
    func contentView(progress:CGFloat, sourceIndex:Int, targetIndex:Int);
}

class ContentPageView: UIView {
    private var viewControllers : [UIViewController]?
    private weak var parentController : UIViewController?
    private var startOffsetX : CGFloat = 0.0
    private var isForbid : Bool = false
    
    
    weak var delegate : ContentPageViewDelegate?
    
    
    private lazy var collectView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.frame.size)!
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        let collectView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectView.showsHorizontalScrollIndicator = false
        collectView.isPagingEnabled = true
        collectView.bounces = false
        collectView.dataSource = self
        collectView.delegate = self
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
        
        return collectView
    }()
    
    init(frame: CGRect, controllers : [UIViewController], parentController:UIViewController) {
        self.viewControllers = controllers
        self.parentController = parentController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ContentPageView {
    private func setupUI() {
        
        for childVc in viewControllers ?? [UIViewController]() {
            parentController?.addChild(childVc)
        }
        
        addSubview(collectView)
        collectView.frame = bounds
    }
    
}

extension ContentPageView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath)
        let childVc = viewControllers?[indexPath.item]
        childVc?.view.frame = self.bounds
        cell.contentView.addSubview(childVc?.view ?? UIView())
        return cell
    }
}


extension ContentPageView {
    func setCurrentIndex(index:Int) {
        isForbid = true
        let offsetX = kScreenWidth * CGFloat(index)
        collectView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

extension ContentPageView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if isForbid {
            return
        }
        
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if (currentOffsetX > startOffsetX) {
            // 左滑
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            
            sourceIndex = Int(currentOffsetX/scrollViewW)
            
            targetIndex = sourceIndex + 1
            
            if (targetIndex >= viewControllers?.count ?? 0 ) {
                let count = viewControllers?.count ?? 1
                targetIndex = count - 1
            }
            
            
            if (currentOffsetX - startOffsetX == scrollViewW) {
                progress = 1.0
                targetIndex = sourceIndex
            }
            
        
            print("左滑：\(targetIndex)  \(sourceIndex) \(progress)")
            
        } else {
            // 右滑
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            
            targetIndex = Int(currentOffsetX/scrollViewW)
            
            sourceIndex = targetIndex +  1
            if (sourceIndex >= viewControllers?.count ?? 0 ) {
                let count = viewControllers?.count ?? 1
                sourceIndex = count - 1
            }
            
            print("右滑：\(targetIndex)  \(sourceIndex)")
        }
        
        delegate?.contentView(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbid = false
        startOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        let tempMargin = startOffsetX/scrollViewW
        let tempIntMargin = Int(tempMargin)
        if (tempMargin - CGFloat(tempIntMargin)) != 0.0 {
            startOffsetX = scrollViewW * CGFloat(tempIntMargin)
        }
    }
}
