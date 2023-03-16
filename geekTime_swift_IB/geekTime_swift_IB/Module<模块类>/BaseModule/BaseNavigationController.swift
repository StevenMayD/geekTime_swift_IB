//
//  BaseNavigationController.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/15.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()


        loadViewUI()
        initData()
    }
    
    func loadViewUI() {
        // tab文本颜色 其他页面返回后 设置为黑色(从其他子页面返回，默认会显示蓝色)
        UITabBar.appearance().unselectedItemTintColor = .black
        // tab文本颜色设置为黑色(默认为系统蓝色) tabBarItem在导航上，所以导航下的ViewController则都会是黑色
        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    
    func initData() {
        
    }

}
