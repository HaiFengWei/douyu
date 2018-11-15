//
//  BaseNavigationController.swift
//  yhnote
//
//  Created by 韦海峰 on 2018/11/15.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    var PopVCDelegate : UIGestureRecognizerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PopVCDelegate = self.interactivePopGestureRecognizer?.delegate;
        self.delegate      = self;
        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            let barButtonItem : UIBarButtonItem = UIBarButtonItem.init(image: (UIImage.init(named: "nav_back"))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.done, target: self, action: #selector(back))
            viewController.navigationItem.leftBarButtonItem = barButtonItem
        }
        // 这个方法才是真正执行跳转
//        [super pushViewController:viewController animated:animated];
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func back() {
         self.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //判断当前显示的控制器是否为根控制器.
        //清空滑动返回手势的代理就能实现
        self.interactivePopGestureRecognizer?.delegate = ((viewController == self.viewControllers[0]) ? self.PopVCDelegate : nil)
    }
}
