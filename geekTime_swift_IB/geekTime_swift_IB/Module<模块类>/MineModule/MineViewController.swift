//
//  MineViewController.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/15.
//

import UIKit

class MineViewController: BaseViewController {
    @IBOutlet weak var tableBgView: UIView!
    var accountCell : CommonCellView!
    var purchasedCell : CommonCellView!
    var orderCell : CommonCellView!
    var groupCell : CommonCellView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadViewUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置导航栏 标题字体颜色
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.red]
    }
    
    func loadViewUI() {
        // 设置标题
        self.title = "我的"
        
        // 在MineViewController所属的BaseNavigationController下设置字体颜色（因为tabBarItem在导航上，这里设置没用）
//        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        // 跳转时隐藏tabbar (不是在这里设置 这样会让切换tab时 也隐藏tab栏，而是在跳转去向 比如loginVC那里设置)
//        self.hidesBottomBarWhenPushed = true
        
        loadTableView();
        
    }
    
    func initData() {
        
    }
    
    @IBAction func loginClick(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewControllerID")
        loginVC.hidesBottomBarWhenPushed = true // 设置在loginVC跳转的位置
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func loadTableView () {
        accountCell = CommonCellView()
        accountCell.icon = R.image.icon_life()
        accountCell.title = "账号"
        tableBgView.addSubview(accountCell)
        accountCell.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
        purchasedCell = CommonCellView()
        purchasedCell.icon = R.image.icon_between()
        purchasedCell.title = "已购"
        tableBgView.addSubview(purchasedCell)
        purchasedCell.snp.makeConstraints { make in
            make.top.equalTo(accountCell.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
        orderCell = CommonCellView()
        orderCell.icon = R.image.icon_document()
        orderCell.title = "商品订单"
        tableBgView.addSubview(orderCell)
        orderCell.snp.makeConstraints { make in
            make.top.equalTo(purchasedCell.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
        groupCell =  CommonCellView()
        groupCell.icon = R.image.icon_live()
        groupCell.title = "我的拼团"
        tableBgView.addSubview(groupCell)
        groupCell.snp.makeConstraints { make in
            make.top.equalTo(orderCell.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
    }
}
