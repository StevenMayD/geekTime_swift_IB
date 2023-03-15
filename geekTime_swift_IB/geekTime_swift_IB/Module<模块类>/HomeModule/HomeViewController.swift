//
//  HomeViewController.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/15.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        loadViewUI()
        initData()
    }
    
    func loadViewUI() {
        // 没有导航 不设置 标题
        self.title = "首页"
        // tab文本颜色设置为黑色(默认为系统蓝色)
        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    
    func initData() {
        
    }


}
