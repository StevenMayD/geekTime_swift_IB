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
                          "https://static001.geekbang.org/resource/image/f7/b4/f79b1fcb2e9eeb1002fd7db4b4fd10b4.jpg"]
        }
        return bannerList
    }
}
