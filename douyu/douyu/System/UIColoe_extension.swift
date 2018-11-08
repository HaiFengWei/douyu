//
//  UIColoe_extension.swift
//  douyu
//
//  Created by 韦海峰 on 2018/11/8.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(r:CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
