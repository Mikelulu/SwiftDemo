//
//  LKSubTableViewCell.swift
//  LKFFM
//
//  Created by Mike on 2017/1/20.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

class LKSubTableViewCell: UITableViewCell {

    // MARK: - 懒加载
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 50 * 0.5
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var nameLb: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textColor = UIColor(colorLiteralRed: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        return lable
    }()
    
    lazy var contentLb: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = UIColor(colorLiteralRed: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        lable.numberOfLines = 0
       return lable
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        addSubviews()
    }
    
    override func layoutSubviews() {
        self.iconImage.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        self.nameLb.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImage.snp.right).offset(10)
            make.centerY.equalTo(self.iconImage.snp.centerY)
        }
        self.contentLb.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImage.snp.left)
            make.right.equalTo(self.snp.right).offset(-15)
            make.top.equalTo(self.iconImage.snp.bottom).offset(10)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - 子视图
extension LKSubTableViewCell {
    func addSubviews() {
        addSubview(self.iconImage)
        addSubview(self.nameLb)
        addSubview(self.contentLb)
    }
}
