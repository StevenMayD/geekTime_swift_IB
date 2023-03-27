//
//  CourseTableViewCell.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/24.
//

import UIKit

/* 父类CommonTableViewCell支持泛型
 CourseTableViewCell就可以指定泛型为Course了，传达给父类，CourseTableViewCell的item具体类型为Course
 */
class CourseTableViewCell: CommonTableViewCell<Course> {
    // 属性
    let priceLabel : UILabel
    let courseImageView : UIImageView
    // 重写父类item属性
    override var item: Course? {
        didSet {
            if let course = self.item {
                self.textLabel?.text = course.name // UITableViewCell的属性
                self.detailTextLabel?.text = course.desc
                self.priceLabel.text = "￥\(course.price)"
                self.courseImageView.kf.setImage(with: URL(string: course.imageUrl))
            }
        }
    }
    
    // 重写父类初始化方法
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        priceLabel = UILabel(frame: .zero)
        courseImageView = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 布局属性控
    private func setupView() {
        textLabel?.textColor = UIColor.black
        detailTextLabel?.textColor = UIColor.black
        detailTextLabel?.numberOfLines = 2
        priceLabel.textColor = UIColor.orange
//        courseImageView.clipsToBounds = true
        contentView.addSubview(priceLabel)
        contentView.addSubview(courseImageView)
        
        courseImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(contentView).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        
        // cell本身的控件布局位置
        textLabel?.snp.makeConstraints({ make in
            make.left.equalTo(courseImageView.snp.right).offset(12)
            make.top.equalTo(courseImageView)
            make.right.equalTo(contentView)
        })
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(textLabel!)
            make.centerY.equalTo(contentView)
        }
        detailTextLabel?.snp.makeConstraints({ make in
            make.left.equalTo(textLabel!)
            make.bottom.equalTo(courseImageView)
            make.right.equalTo(contentView).offset(-20)
        })
    }
}
