//
//  ViewController.swift
//  SPNoticeViewDemo
//
//  Created by 韦海峰 on 2018/11/12.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let noticeView = SPNoticeView(noticeTitle: "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试", showTime: 1.5)
        noticeView.show()
    }

}

