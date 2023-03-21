//
//  HomeViewController.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/15.
//

import UIKit
import Kingfisher // 图片加载库

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, BannerViewDataSource, BannerViewDelegate {
    /** 协议方法 */
    func numberOfBanners(_ bannerView: BannerView) -> Int {
        return FakeData.createBanners().count
    }
    
    func viewForBanner(_ bannerView: BannerView, index: Int, contentView: UIView?) -> UIView {
        if let view = contentView as? UIImageView {
            view.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return view
        } else {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return imageView
        }
    }
    
    func didSelectBanner(_ banner: BannerView, index: Int) {
        
    }
    
    @IBOutlet weak var bannerBgView: UIView!
    @IBOutlet weak var courseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadViewUI()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func initData() {
        
    }
    
    func loadViewUI() {
        // 没有导航 不设置 标题
        self.title = "首页"
        // tab文本颜色 其他页面返回后 设置为黑色(从其他子页面返回，默认会显示蓝色)
        UITabBar.appearance().unselectedItemTintColor = .black
        // tab文本颜色 初始状态 设置为黑色(默认为系统蓝色)
        self.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        
        loadBannerView()
        loadTableView()
    }
    
    // 加载滚动视图
    func loadBannerView() {
        let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176))
        bannerView.dataSource = self
        bannerView.isInfinite = true
        bannerView.autoScrollInterval = 3 // 3秒轮播间隔
        bannerBgView.addSubview(bannerView)
    }

    // 加载课程列表
    func loadTableView() {
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        }
        return cell!
    }
}
