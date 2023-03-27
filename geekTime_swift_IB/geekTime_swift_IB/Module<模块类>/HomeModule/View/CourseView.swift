//
//  CourseView.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/24.
//

import UIKit
import SnapKit

// CourseView类的协议
protocol CourseViewDelagate: AnyObject {
    // 点击cell的回调：使外界处理cell点击的后续操作
    func didSelectItem<Item>(_ item: Item)
}

/* 课程视图：父类为UIView，遵循UICollectionViewDataSource等协议
CouseView接受两种泛型类型：
    一个为ItemType：表示某种数据模型，由调用方指定
    一个为CellType：表示继承自CommonTableViewCell的某种子类cell，由调用方指定
 */
class CourseView<ItemType, MyCellType:CommonTableViewCell<ItemType>>: UIView, UITableViewDataSource, UITableViewDelegate {
    // 属性
    var courseTableView : UITableView // 课程列表视图
    var courseList : [ItemType]!  = [] { // 课程列表数据：泛型
        didSet {
            self.courseTableView.reloadData()
        }
    }
    weak var delegate : CourseViewDelagate?
    
    override init(frame: CGRect) {
        /* swift要求属性要初始化，并且得在 super.init(frame: frame)之前
         Property 'self.courseTableView' not initialized at super.init call
         */
        courseTableView = UITableView(frame: .zero, style: .plain) // 所以，暂定0尺寸布局
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        courseTableView.dataSource = self
        courseTableView.delegate = self
        self.addSubview(courseTableView)
        courseTableView.snp.makeConstraints { make in // 设置实际的尺寸布局
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: --- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MyCellType? = tableView.dequeueReusableCell(withIdentifier: "CellId") as? MyCellType
        if cell == nil {
            /*
             报错：Constructing an object of class type 'MyCellType' with a metatype value must use a 'required' initializer
             要求："使用元类型值构造类类型为“ CellType”的对象必须使用“必需”的初始化程序"
             解决：CommonTableViewCell的初始化方法init需要添加 required
             */
            cell = MyCellType(style: .subtitle, reuseIdentifier: "CellId")
        }
        cell?.item = courseList[indexPath.row]
        return cell!
    }
    
    // MARK: --- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(courseList[indexPath.row]) // 代理调用协议方法
        tableView.deselectRow(at: indexPath, animated: true) // 取消选中效果
    }
}
