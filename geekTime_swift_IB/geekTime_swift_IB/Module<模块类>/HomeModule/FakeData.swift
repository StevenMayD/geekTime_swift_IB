//
//  FakeData.swift
//  geekTime_swift_IB
//
//  Created by 董帅文 on 2023/3/17.
//

import Foundation

class FakeData {
    static var bannerList = [String]()
    
    static func createBanners() -> [String] {
        if bannerList.count == 0 {
            bannerList = ["https://static001.geekbang.org/resource/image/30/86/307332b7ba9556ba1e38c358ad6aab86.jpg",
                          "https://static001.geekbang.org/resource/image/4e/c5/4ea96e35e97f37914c1703d1cf4b69c5.jpg",
                          "https://static001.geekbang.org/resource/image/f7/b4/f79b1fcb2e9eeb1002fd7db4b4fd10b4.jpg",
                          "https://img0.baidu.com/it/u=2043819764,3430712587&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
                          "https://img1.baidu.com/it/u=1329707500,2197086171&fm=253&fmt=auto&app=138&f=JPEG?w=828&h=402"]
        }
        return bannerList
    }
}
