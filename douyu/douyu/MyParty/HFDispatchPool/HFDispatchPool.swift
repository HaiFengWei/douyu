//
//  HFDispatchPool.swift
//  douyu
//
//  Created by 韦海峰 on 2018/11/7.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

/// 控制线程并发数量
class HFDispatchPool: NSObject {
    // 计算属性，获取队列
    var queue : DispatchQueue? {
        index = index + 1
        let tempIndex = index%queueCount
        return queuePool?[tempIndex]
    }
    
    // 私有储存属性
    private var queuePool : [DispatchQueue]? = [DispatchQueue]()
    private var index:Int = -1
    private var queueCount = 0

    /// 自定义构造函数
    ///
    /// - Parameters:
    ///   - queueName:  线程名
    ///   - queueCount: 线程数
    ///   - qos:        线程执行级别
    init(queueName:String, queueCount:Int, qos:DispatchQoS) {
        self.queueCount     = queueCount
        for _ in 0...queueCount {
            let serialQueue = DispatchQueue(label: queueName, qos: qos)
            self.queuePool?.append(serialQueue)
        }
    }
    
    /// 根据当前项目活跃进程数量创建线程池
    ///
    /// - Parameter defaultPoolForQOS: 线程执行级别
    convenience init(defaultPoolForQOS:DispatchQoS) {
        let queueCount = ProcessInfo.processInfo.activeProcessorCount
        self.init(queueName: "com.hfdispatch.defaultQueuePool", queueCount: queueCount, qos: DispatchQoS.userInitiated)
    }
    
    deinit {
        queuePool?.removeAll()
        queuePool = nil
        print("释放线程池")
    }
}
