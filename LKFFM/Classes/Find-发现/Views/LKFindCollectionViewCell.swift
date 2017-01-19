//
//  LKFindCollectionViewCell.swift
//  LKFFM
//
//  Created by Mike on 2017/1/18.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

class LKFindCollectionViewCell: UICollectionViewCell {
 
    var myLabel:UILabel = {
        
        let label = UILabel()
        label.text = "我的小标题"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
        
    }()
    
    var myImageView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        return imageView
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 由于测试，先不考虑 自动布局 后期可以考虑 SnapKit
        self.myLabel.frame = CGRect(x: 10, y: 60, width: frame.size.width - 20, height: 20)
        
        self.myImageView.frame = CGRect(x: 10, y: 0, width: frame.size.width - 20, height: 60)

        
        self.contentView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        self.contentView .addSubview(self.myLabel)
        self.contentView .addSubview(self.myImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
