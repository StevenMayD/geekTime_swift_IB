//
//  LoginViewController.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/15.
//

import UIKit
import CoreMedia

class LoginViewController: BaseViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "登录"
        
        self.initData()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginBtn.setBackgroundImage(R.image.logo(), for: .normal)
    }
    
    func initData() {
        
    }
    
    func setupView() {
        // 导航栏 返回按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.red
        // 设置导航栏 标题字体颜色
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.green]
        // 设置导航栏 背景色
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGray

        let phoneIconView = UIImageView(image: R.image.icon_phone()) // R.swift：资源管理的三方库
        phoneTextField.leftView = phoneIconView // Textfield左边图标
        phoneTextField.leftViewMode =  .always // leftView设置 一直显示模式 才会显示
        let passwordIconView = UIImageView(image: R.image.icon_pwd())
        passwordTextField.leftView = passwordIconView
        passwordTextField.leftViewMode = .always
        
        // 单纯设置背景色，点击按钮没有任何动效
//        loginBtn.backgroundColor = UIColor.hexColor(0xf8892e)
        // 设置背景图片，点击按钮会有一个高亮的效果
        loginBtn.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for: .normal)
    }

}
