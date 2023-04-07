//
//  UIColorExtension.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/4/7.
//

import Foundation
import UIKit

extension UIColor {
    // 扩展方法 由十六进制的值，得到color (6位数，每两位分别代表red，green，blue)
    static func hexColor(_ hexValue: Int, alphaValue: Float) -> UIColor {
        return UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255,     //  与0xFF0000，再移动16位，再除以255，得到red值
                       green: CGFloat((hexValue & 0x00FF00) >> 8) / 255,    //  与0x00FF00，再移动8位，再除以255，得到green值
                       blue: CGFloat((hexValue & 0x0000FF)) / 255,          //  与0x0000FF，再除以255，得到blue值
                       alpha: CGFloat(alphaValue))
    }
    
    static func hexColor(_ hexValue: Int) -> UIColor {
        return hexColor(hexValue, alphaValue: 1)
    }
    // 扩展便携初始化方法
    convenience init(_ hexValue: Int, alphaValue: Float) {
        self.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255,
                  green: CGFloat((hexValue & 0x00FF00) >> 8) / 255,
                  blue: CGFloat((hexValue & 0x0000FF)) / 255,
                  alpha: CGFloat(alphaValue))
    }
    convenience init(_ hexValue: Int) {
        self.init(hexValue, alphaValue: 1)
    }
    
    // 颜色转图片(用到UIGraphics)
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1) // 指定区域
        UIGraphicsBeginImageContext(rect.size) // 开始绘制操作
        let context = UIGraphicsGetCurrentContext() // 得到绘制
        context?.setFillColor(self.cgColor) // 设定填充颜色
        context?.fill(rect) // 进行区域填充
        let image = UIGraphicsGetImageFromCurrentImageContext() // 得到image
        UIGraphicsEndPDFContext() // 结束绘制
        return image!
    }
}
