//
//  BannerView.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/16.
//

import UIKit
import SnapKit // 自动布局库

/** 协议部分 ：AnyObject使得协议BannerViewDataSource 只能被类遵循 */
protocol BannerViewDataSource : AnyObject { // 数据源相关
    // banner数量
    func numberOfBanners(_ bannerView: BannerView) -> Int
    
    // banner内容
    func viewForBanner(_ bannerView: BannerView, index: Int, contentView: UIView?) -> UIView
}

protocol BannerViewDelegate : AnyObject { // 操作点击回调相关
    func didSelectBanner(_ banner: BannerView, index: Int)
}

/** 滚动视图（由UICollectionView实现） */
class BannerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    /**
     属性列表：不再需要property描述
     */
    static var cellId = "bannerViewCellId"
    static var contentViewTag = 10086
    var collectionView : UICollectionView
    var flowLayout : UICollectionViewFlowLayout // CollectionView布局属性配置
    var pageControl : UIPageControl // 声明小白点
    var timer : Timer? // 轮播计时器
    var autoScrollInterval : Float = 0 { // 轮播间隔
        didSet {
            if self.autoScrollInterval > 0 {
                self.startAutoScroll()
            } else {
                self.stopAutoScroll()
            }
        }
    }
    
    /* 两个协议类型的属性（代理需要weak修饰）
     但使用weak又会报错：weak不能修饰协议类型
     'weak' must not be applied to non-class-bound 'BannerViewDelegate'; consider adding a protocol conformance that has a class bound
     解决方法有两种：
     1、 给协议添加 @objc修饰符 “ @objc protocol BannerViewDataSource “
     2、 让协议只能被类遵循，使用 ” : AnyObject ” , 让协议只允许被 类遵循 （protocol BannerViewDataSource : AnyObject）
     */
    weak var delegate: BannerViewDelegate?
    weak var dataSource: BannerViewDataSource! {
        // 属性观察者：监听dataSource被设置了 则触发加载collectionView
        didSet {
            pageControl.numberOfPages = self.dataSource.numberOfBanners(self) // 配置小白点数据
            collectionView.reloadData()
        }
    }
    
    
    /**
     方法列表
     */
    // 界面初始化：属性创建
    override init(frame: CGRect) {
        // 属性不在self.使用
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.minimumLineSpacing = 0 // collectionView的单元格间的间隔为0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal // 水平方向滑动布局
        
        let collectionViewFrame = CGRect(x: 0, y: 0,
                                         width: frame.width, height: frame.height)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: flowLayout)
        pageControl = UIPageControl() // 创建小白点
        
        super.init(frame: frame)
        // 调用父类方法之后 才能定义布局自己的界面
        self.setupView();
    }
    
    // UIView的子类必须实现该方法
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder)没有实现")
    }
    
    func setupView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        /** 注册，否则报错
         CellId - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'
         */
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BannerView.cellId)
        collectionView.isPagingEnabled = true // 分页：滑动时分页
        collectionView.showsHorizontalScrollIndicator = false // 不显示滚动指示器
        
        // 布局collectionView：父视图先添加 才能以父视图自动布局,否则报错
        self.addSubview(collectionView)
        self.addSubview(pageControl) // 添加小白点
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // 布局小白点
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(8)
        }
        
    }
    // 实现自动轮播
    func startAutoScroll() {
        /*
         guard语句，类似if语句，基于布尔值表达式来执行语句。
         使用guard语句来要求一个条件必须是真，才能执行guard之后的语句。
         与if语句不同，guard语句总是有一个else分局，else分局里的代码会在条件不为真的时候执行
         */
        guard autoScrollInterval>0 && timer==nil else {
            // 如果轮播间隔小于0 且 定时器不存在 则直接返回
            return
        }
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(autoScrollInterval), target: self, selector: #selector(flipNext), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopAutoScroll() {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
    }
    
    // 切换轮播界面：作为定时器调用的方法 需要添加 @objc
    @objc func flipNext() {
        // 轮播视图的父视图 或 根视图 如果不存在 则直接返回
        guard let _ = superview, let _ = window else {
            return
        }
        // 总页数
        let totalPageNumber = dataSource.numberOfBanners(self)
        guard totalPageNumber > 1 else {
            return
        }
        
        // 当前页：round()舍入函数，得到整数值2.0；    Int()取整函数，得到整数2
        let currentPageNumber = Int(round(collectionView.contentOffset.x / collectionView.frame.width))
        // 下一页
        var nextPageNumer = currentPageNumber + 1
        if nextPageNumer >= totalPageNumber {
            nextPageNumer = 0 // 重置为第一页
        }
        // 滚动视图翻至下一页
        collectionView.setContentOffset(CGPoint(x: collectionView.frame.width * CGFloat(nextPageNumer), y: 0), animated: true)
        pageControl.currentPage = nextPageNumer
    }
    
    // MARK: --- UICollectionViewDataSource
    // 单元格内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerView.cellId, for: indexPath)
        let index = indexPath.row
        
        if let view = cell.contentView.viewWithTag(BannerView.contentViewTag) {
            // 可重用的view存在
            let _ = dataSource.viewForBanner(self, index: index, contentView: view)
        } else {
            let newView = dataSource.viewForBanner(self, index: index, contentView: nil)
            newView.tag = BannerView.contentViewTag
            cell.contentView.addSubview(newView)
            // 布局imageview
            newView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        return cell
    }
    
    // 每节的单元格数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 协议numberOfBanners调用numberOfBanners方法 获得单元格数量
        return dataSource.numberOfBanners(self)
    }
    
    // 节的数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // MARK: --- UICollectionViewDelegate
    
    // MARK: --- UICollectionViewFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
