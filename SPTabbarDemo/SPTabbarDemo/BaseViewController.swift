//
//  BaseViewController.swift
//  SPTabbarDemo
//
//  Created by 韦海峰 on 2018/11/10.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

class BaseViewController: SPTabbarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("isiPhoneX:\(sp_isiPhoneX)   isiPhoneXs:\(sp_isiPhoneXs)")
        /// test控制器
        var viewControllers : [UIViewController] = [UIViewController]()
        for index in 0...20 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
            
            if index%2==0 {
                vc.sp_tabItemTitle = "测试\(index)"
            } else {
                vc.sp_tabItemTitle = "测试\(index)测试"
            }
            
            viewControllers.append(vc)
        }
        
        self.viewControllers = viewControllers
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
