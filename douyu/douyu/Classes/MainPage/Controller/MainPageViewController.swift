//
//  MainPageViewController.swift
//  douyu
//
//  Created by 韦海峰 on 2018/11/5.
//  Copyright © 2018年 sepeak. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40.0

class MainPageViewController: BaseViewController {

    // Mark:- 懒加载
    private lazy var titlePageView : TitlePageView = { [weak self] in
        let titleFram = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: kTitleViewH)
        let titles = ["测试一","测试二","测试三","测试四"]
        let titleView = TitlePageView.init(frame: titleFram, titles: titles)
        titleView.delegate = self;
        titleView.backgroundColor = UIColor.white
        return titleView;
    }()
    
    lazy var contentPageView : ContentPageView = { [weak self] in
        let pageFram = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight + kTitleViewH, width: kScreenWidth, height: kScreenHeight -  kStatusBarHeight - kNavigationBarHeight - kTitleViewH)
        var controllers = [UIViewController]()
        for _ in 0...3 {
            let vc = UIViewController();
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            controllers.append(vc)
        }
        
        let contentPageView = ContentPageView(frame: pageFram, controllers: controllers, parentController: self ?? UIViewController())
        contentPageView.delegate = self
        return contentPageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        // 设置UI界面
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 测试线程池并发数量控制
//        let pool = HFDispatchPool.init(defaultPoolForQOS: DispatchQoS.userInitiated)
//        for index:Int in 0...100 {
//            let queue = pool.queue
//            queue?.async {
//                if index%2==0 {
//                    print("双数--->\(index)---\(Thread.current)")
//                }
//                else {
//                    print("单数--->\(index)---\(Thread.current)")
//                }
//
//            }
//        }
    }

}


// MARK: - 设置界面
extension MainPageViewController {
    
    /// 创建UI
    private func setupUI() {
        // 添加titleView
        view.addSubview(titlePageView)
        
        view.addSubview(contentPageView)
        contentPageView.backgroundColor = UIColor.purple
    }
    
    /// 设置导航栏
    private func setNavigationBar() {
        
    }
}

extension MainPageViewController : TitlePageViewDelegate,ContentPageViewDelegate {
    func titlePageView(titleView: TitlePageView, selectedIndex index: Int) {
        contentPageView.setCurrentIndex(index: index)
    }
    
    func contentView(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titlePageView.settitleWithPtogress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

