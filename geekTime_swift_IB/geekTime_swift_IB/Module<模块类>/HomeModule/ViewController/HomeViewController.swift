//
//  HomeViewController.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/15.
//

import UIKit
import Kingfisher // 图片加载库

class HomeViewController: BaseViewController, BannerViewDataSource, BannerViewDelegate, CourseViewDelagate {
    @IBOutlet weak var bannerBgView: UIView!
    @IBOutlet weak var courseTableBgView: UIView! // 自动铺满布局的背景视图
    
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
        bannerView.delegate = self
        bannerView.isInfinite = true
        bannerView.autoScrollInterval = 3 // 3秒轮播间隔
        bannerBgView.addSubview(bannerView)
    }

    // 加载课程列表
    func loadTableView() {
        let courseView = CourseView<Course, CourseTableViewCell>(frame: .zero) // 先创建对象，暂定0尺寸
        courseView.courseList = FakeData.createCourses()
        courseView.delegate = self
        courseTableBgView.addSubview(courseView) // tableView的背景界面上 再添加对象
        courseView.snp.makeConstraints { make in // 后重新布局对象
            make.edges.equalToSuperview() // 铺满背景视图即可
        }
    }
    
    // MARK: - BannerViewDataSource /** 协议方法 */
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
    
    // MARK: - BannerViewDelegate
    func didSelectBanner(_ banner: BannerView, index: Int) {
        print("滚动视图点击了第：\(index) 个")
    }
    
    // MARK: - CourseViewDelagate
    func didSelectItem<Item>(_ item: Item) {
        // 由于模型支持泛型，写法也变了：需要先判断具体类型
        if let course = item as? Course {
            print("课程选择：" + course.name) // 无时间记录的纯粹打印
//            NSLog("课程选择：%@", course.name) // 含时间记录 打印
        }
    }
}
