//
//  common.swift
//  ICO
//
//  Created by yunke on 2018/1/23.
//  Copyright © 2018年 yunke. All rights reserved.
//

import UIKit
import SnapKit

let guideCount = 4
//屏幕的尺寸信息
let ScreenWidth = UIScreen.main.bounds.width

let ScreenHeight = UIScreen.main.bounds.height

//比例
let pt2x :CGFloat = 2.0

let scale :CGFloat = ScreenWidth/375.0

//实际距离
func ykmargin(margin: CGFloat) -> CGFloat{
    return margin * scale / pt2x
}

//系统字号
func yksysFont(font:CGFloat) -> UIFont {
    
    return  UIFont.systemFont(ofSize: font * scale / pt2x)
}
func ykboldFont(font:CGFloat) -> UIFont {
 
    return  UIFont.boldSystemFont(ofSize: font * scale / pt2x)
}
//颜色
func ykColor(rgbValue:NSInteger,alpha:CGFloat) -> UIColor {
    return UIColor.init(red:  CGFloat((rgbValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0xFF)/255.0, alpha: alpha)
}

//全局方法
func ykrandomColor() -> UIColor {
    let r = CGFloat(arc4random() % 256) / 255.0
    let g = CGFloat(arc4random() % 256) / 255.0
    let b = CGFloat(arc4random() % 256) / 255.0
    return UIColor(red: r, green:g, blue: b, alpha: 1)
}
//iPhone X
func isIphoneX()->Bool{
    if ScreenHeight == 812.0 {
        return true
    }
    return false
}
//状态栏高度
func statusHeight()->CGFloat{
return UIApplication.shared.statusBarFrame.size.height
}

let hasLargeTitle = false
//导航+状态高度
func navStatusHeight()->CGFloat{
    if isIphoneX() {
        if hasLargeTitle {
            return 96.0
        }
        return 88.0
    }
    return 64.0
}
//tabBar高度
func tabBarHeight()->CGFloat{
    if isIphoneX() {
        return 83.0
    }
    return 49.0
}
func dangerousHeight()->CGFloat{
    if isIphoneX(){
        return 34.0
    }
    return 0.0
}
//定义全局的格式化对象
let sharedDateFormater = DateFormatter()
func getCurrentVC() -> UIViewController? {
    for window in UIApplication.shared.windows.reversed() {
        var tempView: UIView? = window.subviews.last
        for subview in window.subviews.reversed() {
            if subview.classForCoder == NSClassFromString("UILayoutContainerView") {
                tempView = subview
                break
            }
        }
        
        var nextResponder = tempView?.next
        
        var next: Bool {
            return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController || nextResponder?.classForCoder == NSClassFromString("UIInputWindowController")
        }
        
        while next{
            tempView = tempView?.subviews.first
            if tempView == nil {
                return nil
            }
            nextResponder = tempView!.next
        }
        if let currentVC = nextResponder as? UIViewController {
            return currentVC
        }
    }
    return nil
}


