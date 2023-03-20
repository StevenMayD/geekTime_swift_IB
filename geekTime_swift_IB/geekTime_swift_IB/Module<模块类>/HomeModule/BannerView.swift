//
//  BannerView.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/16.
//

import UIKit
import SnapKit // 自动布局库

/** 协议部分 */
protocol BannerViewDataSource { // 数据源相关
    // banner数量
    func numberOfBanners(_ bannerView: BannerView) -> Int
    
    // banner内容
    func viewForBanner(_ bannerView: BannerView, index: Int, contentView: UIView?) -> UIView
}

protocol BannerViewDelegate { // 操作点击回调相关
    func didSelectBanner(_ banner: BannerView, index: Int)
}

/** 滚动视图（由UICollectionView实现） */
class BannerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    /**
     属性列表：不再需要property描述
     */
    var collectionView : UICollectionView
    var flowLayout : UICollectionViewFlowLayout // CollectionView布局属性配置
    static var cellId = "bannerViewCellId"
    static var contentViewTag = 10086
    
    // 两个协议类型的属性
    var delegate: BannerViewDelegate?
    var dataSource: BannerViewDataSource! {
        didSet { // 监听器：监听dataSource有被赋值 则触发加载collectionView
            collectionView.reloadData()
        }
    }
    
    
    /**
     方法列表
     */
    // 界面初始化
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
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
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
