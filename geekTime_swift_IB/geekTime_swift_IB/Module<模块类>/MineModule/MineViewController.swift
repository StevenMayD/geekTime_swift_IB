//
//  MineViewController.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/15.
//

import UIKit

class MineViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        loadViewUI()
        initData()
    }
    
    func loadViewUI() {
        // 设置标题
        self.title = "我的"
        // 在MineViewController所属的BaseNavigationController下设置字体颜色（因为tabBarItem在导航上，这里设置没用）
//        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        // 跳转时隐藏tabbar
        self.hidesBottomBarWhenPushed = true
    
    }
    
    func initData() {
        
    }

}
