//
//  CommonCellView.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/4/11.
//

import UIKit

/* 注意为什么继承自UIControl
 因为UIControl本身是继承自UIView（class UIControl : UIView）
 由于需要视图有点击选中的效果，需要继承自UIControl，而不是UIView了
 (UIControl本身有isHighlighted属性,重写它，来实现点击后高亮瞬间再失去高亮的动画)
 这就是为什么UIButton是继承自UIControl
 */
class CommonCellView: UIControl {
    var title: String? {
        // 属性监听器：当检测到title发生变化时 调用
        didSet {
            self.titleView.text = self.title
        }
    }
    var icon: UIImage? {
        didSet {
            self.iconView.image = self.icon
        }
    }
    // 重写isHighlighted的属性，进行监听
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = self.isHighlighted
            if self.isHighlighted {
                // 点击高亮 则显示highlightView，且不透明
                self.highlightView.alpha = 1
                self.highlightView.isHidden = false
            } else {
                // 撤销点击 则隐藏highlightView，且完全透明
                UIView.animate(withDuration: 0.5) {
                    self.highlightView.alpha = 0
                } completion: { (finished) in
                    self.highlightView.isHidden = true
                }

            }
        }
    }
    var titleView: UILabel
    var iconView: UIImageView
    var bottomLine: UIView
    var arrowView: UIImageView
    var highlightView: UIView // 点击效果视图：通过变换它的 隐藏属性和透明度 来实现点击效果
    
    override init(frame: CGRect) {
        titleView = UILabel()
        iconView = UIImageView()
        bottomLine = UIView()
        arrowView = UIImageView()
        arrowView.image = R.image.icon_right_arrow()
        highlightView = UIView()
        super.init(frame: frame)
        self.backgroundColor = .white // 背景色为白色
        self.setupView()
    }
    
    func setupView() {
        // 默认状态 不显示高亮视图highlightView
        highlightView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        highlightView.isHidden = true
        highlightView.alpha = 0
        self.addSubview(highlightView)
        highlightView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 所有边距布局
        }
        
        self.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        self.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        self.addSubview(bottomLine)
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-0.3)
            make.width.equalToSuperview()
            make.height.equalTo(0.3)
        }
        
        self.addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

