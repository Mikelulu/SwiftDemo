//
//  LKBannerView.swift
//  LKFFM
//
//  Created by Mike on 2017/1/12.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit
import SDCycleScrollView

class LKBannerView: UIView {

    lazy var scrollerView: SDCycleScrollView = {
      let banerview = SDCycleScrollView(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height), delegate: self, placeholderImage: nil)
        self.addSubview(banerview!)
//        banerview?.snp.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
//        }
        banerview?.autoScrollTimeInterval = 3.0
        return banerview!
    }()
    
    /// 传入图片数组
    func getScrollImgSource(source: [BannerModel]) {
        
        //初始化一个图片数组
        var picArr:[String] = [String]()
        
        //遍历数组
        for model in source {
            //将图片添加到数组中
            picArr.append(model.pic)
        }
        
        scrollerView.imageURLStringsGroup = picArr
    }
}

// MARK: - SDCycleScrollViewDelegate
extension LKBannerView: SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        LKLog("点击了第\(index)张")
    }
}
