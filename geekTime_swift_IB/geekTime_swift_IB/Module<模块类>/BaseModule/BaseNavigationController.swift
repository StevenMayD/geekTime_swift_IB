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
        // tab文本颜色设置为黑色(默认为系统蓝色) tabBarItem在导航上，所以导航下的ViewController则都会是黑色
        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }
    
    func initData() {
        
    }

}
