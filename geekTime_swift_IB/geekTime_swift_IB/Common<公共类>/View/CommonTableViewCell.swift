//
//  CommonTableViewCell.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/24.
//

import UIKit

/* CommonTableViewCell支持泛型<ItemType>， 子类就可以自己定义item属性的类型，否则 属性无法使用泛型
 这里的ItemType不是一个系统类型，可以随便自定义，字面意思为“某种项目类型”
 */
class CommonTableViewCell<ItemType>: UITableViewCell {
    /*
     属性必须指定类型，但是作为父类，不知道子类的属性具体是什么类型，这样就可以使用泛型
     子类继承自CommonTableViewCell时，需要指明自己泛型属性的具体类型
     定义一个属性item(类型为泛型) 用于装载cell内容
     */
    var item: ItemType?
    
    // 使用CommonListCell时，要求 "使用元类型值构造类类型为“ CellType”的对象必须使用“必需”的初始化程序" required
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

