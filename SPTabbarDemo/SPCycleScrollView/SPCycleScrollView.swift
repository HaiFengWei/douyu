//
//  SPCycleScrollView.swift
//  SPTabbarDemo
//
//  Created by 韦海峰 on 2018/11/10.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

private let collectionCellId = "SPCycleScrollViewCollectionCellId"

class SPCycleScrollView: UIView {
    
    // MARK: - 数据源API
    /** 网络图片 url string 数组 */
    var imageURLStringsGroup : [NSString]?
    /** 每张图片对应要显示的文字数组 */
    var titlesGroup : [NSString]?
    /** 本地图片数组 */
    var localizationImageNamesGroup : [NSString]?
    
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
        collectionView.register(SPCollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
        return collectionView
        }()
    
    // MARK: - 快速构造方法
    /// 快速创建网络图片加载
    ///
    /// - Parameters:
    ///   - frame:                位置尺寸
    ///   - imageURLStringsGroup: 图片Url数组
    ///   - titlesGroup:          标题数组
    init(frame: CGRect, imageURLStringsGroup: [NSString], titlesGroup: [NSString]) {
        self.imageURLStringsGroup = imageURLStringsGroup
        self.titlesGroup = titlesGroup
        super.init(frame: frame)
    }
    
    
    /// 快速创建本地图片加载
    ///
    /// - Parameters:
    ///   - frame:                       位置尺寸
    ///   - localizationImageNamesGroup: 图片名字数组
    ///   - titlesGroup:                 标题数组
    init(frame: CGRect, localizationImageNamesGroup: [NSString], titlesGroup: [NSString]) {
        self.localizationImageNamesGroup = localizationImageNamesGroup
        self.titlesGroup = titlesGroup
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 搭建UI
extension SPCycleScrollView {
    func setupUI()  {
        
    }
}


// MARK: - UICollectionViewDataSource
extension SPCycleScrollView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension SPCycleScrollView : UICollectionViewDelegate {
    
}
