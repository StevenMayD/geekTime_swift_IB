//
//  Course.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/24.
//

import Foundation

// 课程模型
struct Course {
    var imageUrl: String // 头图
    var name: String // 课程名称
    var desc: String // 描述
    var price: Int // 价格
    var teacher: String // 讲师
    var total: Int // 课程总数
    var update: Int // 当前更新的课程数量
    var studentCount: Int // 学习者数量
    var detail: String // 详情
    var courseList: String // 课程列表
}
