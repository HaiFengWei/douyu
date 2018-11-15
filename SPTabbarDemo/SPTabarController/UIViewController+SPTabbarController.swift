//
//  UIViewController+SPTabbarController.swift
//  SPTabbarDemo
//
//  Created by 韦海峰 on 2018/11/9.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit


struct SPTabbarControllerKeys {
    static var tabItemTitlekey : String = "tabItemTitlekey"
}

extension UIViewController {
    var sp_tabItemTitle: String? {
        set(newValue) {
            objc_setAssociatedObject(self, &SPTabbarControllerKeys.tabItemTitlekey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, &SPTabbarControllerKeys.tabItemTitlekey) as? String
        }
    }
}
