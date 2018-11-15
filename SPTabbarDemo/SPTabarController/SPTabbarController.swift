//
//  SPTabbarController.swift
//  SPTabbarDemo
//
//  Created by 韦海峰 on 2018/11/9.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

class SPTabbarController: UIViewController {

    // MARK: - 懒加载
    lazy var tabbar : SPtabbar = { [weak self] in
        let tabbar = SPtabbar(frame: CGRect(x: 0, y: sp_statusBarHeight, width: sp_screenW, height: 40))
        tabbar.delegate = self
        return tabbar
    }()
    
    lazy var tabbarContentView : SPtabbarContentView = { [weak self] in
        let tabbarContentView = SPtabbarContentView(frame: CGRect(x: 0, y: sp_statusBarHeight + 40.0, width: sp_screenW, height: sp_screenH - sp_statusBarHeight - 40.0), parentController:self!)
        tabbarContentView.delegate = self
        return tabbarContentView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
    }
}

// MARK: -
// MARK: - 公共方法
extension SPTabbarController {
    
}


// MARK: - 创建UI
extension SPTabbarController {
    func setupUI() {
        view.addSubview(tabbar)
        tabbar.backgroundColor = UIColor.blue
        view.addSubview(tabbarContentView)
    }
}



// MARK: - SPtabbarDelegate ,SPtabbarContentViewDelegate 将tabbar与tabbarContenView联动起来
extension SPTabbarController : SPtabbarDelegate ,SPtabbarContentViewDelegate {
    func sptabbar(didSelectedIndex: Int) {
        tabbarContentView.setCurrentIndex(currentIndex: didSelectedIndex)
    }
    func sptabbarEndScroll(targetIndex: Int) {
        tabbar.setSelectItemIndex(selectedIndex: targetIndex)
    }
    func sptabbarContentView(progress: CGFloat, targetIndex: Int, sourceIndex: Int) {
        tabbar.setTbbarChange(progress: progress, targetIndex: targetIndex, sourceIndex: sourceIndex)
    }
}

extension SPTabbarController : SPTabbarControllerProtocol {
    var viewControllers: [UIViewController]? {
        get {
            return self.tabbarContentView.viewControllers as [UIViewController]
        }
        set(vaule) {

            var titles = [String]()
            for vc in vaule ?? [UIViewController]() {
                if let title = vc.sp_tabItemTitle {
                   titles.append(title)
                } else {
                    titles.append("title is none")
                }
            }
            self.tabbar.titles = titles as [NSString]
            self.tabbarContentView.viewControllers = vaule ?? [UIViewController]()
        }
    }
    
    
}
