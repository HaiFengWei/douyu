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
    private lazy var titlePageView : TitlePageView = {
        let titleFram = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: kTitleViewH)
        let titles = ["测试一","测试二","测试三","测试四"]
        let titleView = TitlePageView.init(frame: titleFram, titles: titles)
        titleView.backgroundColor = UIColor.white
        return titleView;
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
        let pool = HFDispatchPool.init(defaultPoolForQOS: DispatchQoS.userInitiated)
        for index:Int in 0...100 {
            let queue = pool.queue
            queue?.async {
                if index%2==0 {
                    print("双数--->\(index)---\(Thread.current)")
                }
                else {
                    print("单数--->\(index)---\(Thread.current)")
                }
                
            }
        }
    }

}


// MARK: - 设置界面
extension MainPageViewController {
    
    /// 创建UI
    private func setupUI() {
        // 添加titleView
        view.addSubview(titlePageView)
    }
    
    /// 社会导航栏
    private func setNavigationBar() {
        
    }
}
