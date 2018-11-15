//
//  SPCommon.swift
//  SPTabbarDemo
//
//  Created by 韦海峰 on 2018/11/10.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit
// MARK: - 系统常用常量
/// 屏幕宽度
let sp_screenW : CGFloat = UIScreen.main.bounds.size.width
/// 屏幕高度
let sp_screenH : CGFloat = UIScreen.main.bounds.size.height


// MARK: - 设备类型判断
// 判断是否是ipad
let sp_isiPad   = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
//判断是否是iPhone
let sp_isiPhone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)

//判断是否iPhone X
let sp_isiPhoneX   = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? (CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!)) : false)
//判断iPHoneXr
let sp_isiPhoneXr  = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? (CGSize(width: 828, height: 1792).equalTo((UIScreen.main.currentMode?.size)!)) : false)
//判断iPhoneXs
let sp_isiPhoneXs  = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? (CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!)) : false)
//判断iPhoneXs Max
let sp_isiPhoneMax = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? (CGSize(width: 1242, height: 2688).equalTo((UIScreen.main.currentMode?.size)!)) : false)

// 是否是iPhone X系列
let sp_isIphoneXSeries = (sp_isiPhoneX == true || sp_isiPhoneXr == true || sp_isiPhoneXs == true || sp_isiPhoneMax == true)

// 状态栏高度
let sp_statusBarHeight                 : CGFloat = (sp_isIphoneXSeries ? 44.0 : 20.0)
// 状态栏和导航栏高度
let sp_statusBarAndNavigationBarHeight : CGFloat = (sp_isIphoneXSeries ? 88.0 : 64.0)
// 底部tabbar高度
let sp_tabbarHeight                    : CGFloat = (sp_isIphoneXSeries ? 83.0 : 49.0)
// 底部安全距离
let sp_tabbarSafeBottomMargin          : CGFloat = (sp_isIphoneXSeries ? 34.0 : 0.0)
// 导航栏高度
let sp_navigationBarHeight             : CGFloat = 44.0

// 控件按比例宽高定义
let sp_screenWidthRatio  = (sp_isiPhone ? (sp_screenW/375.0) : (sp_screenW/768.0))
let sp_screenHeightRatio = (sp_isiPhone ? (sp_screenH/667.0) : (sp_screenH/1024.0))


