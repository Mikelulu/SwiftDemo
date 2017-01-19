//
//  LKSegmentVioew.swift
//  LKFFM
//
//  Created by Mike on 2017/1/12.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

let kSystemOriginColor = UIColor(red: 0.96, green: 0.39, blue: 0.26, alpha: 1.0)
let kSystemBlackColor = UIColor(red: 0.38, green: 0.39, blue: 0.40, alpha: 1.0)

//协议
protocol LKSegmentVioewDelegate: NSObjectProtocol {
    // 当前选中第index个标题的代理回调
    func segMentViewDidSelectedTitle(index: NSInteger)
}

class LKSegmentVioew: UIView {

    //存储btn的数组
    var btnArray = Array<UIButton>()
    
    
     // MARK:- 代理
    weak var delegate: LKSegmentVioewDelegate?
    
    var lastBtn: UIButton!
    
    var titleArray:[String] = [] {
        
        didSet {
            // 配置子标题
            configSubTitles()
        }
    }
    
    //下方的滑块
    lazy var sliderView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.backgroundColor = kSystemOriginColor
        view.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 30, height: 2))
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(5)
        })
        return view
    }()
    
//    // MARK: - 提供给外界ScollerView调用的方法
//    func changeSelectedBtn(btn: UIButton) {
//                btn.isSelected = true
//                sliderView.centerX = btn.centerX
//                sliderView.snp.updateConstraints { (make) in
//        
//                    make.width.equalTo((btn.titleLabel?.getStringWidth(string: (btn.titleLabel?.text)!,fontSize: 15))!)
//                }
//        
//        for item in btnArray{
//            if item == btn {
//                btn.isSelected = true
//                sliderView.centerX = btn.centerX
//                sliderView.snp.updateConstraints { (make) in
//                    
//                    make.width.equalTo((btn.titleLabel?.getStringWidth(string: (btn.titleLabel?.text)!,fontSize: 15))!)
//                }
//                
//            }else {
//                item.isSelected = false
//            }
//        }
//    }
}

// MARK: - 配置子标题
extension LKSegmentVioew {
    fileprivate func configSubTitles() {
        // 每一个titleBtn的宽度
        let btnW = kScreenW / CGFloat(titleArray.count)
        
        for index in 0..<titleArray.count {
            let title = titleArray[index]
            let btn = UIButton(type: .custom)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(kSystemBlackColor, for: .normal)
            btn.setTitleColor(kSystemOriginColor, for: .selected)
            btn.setTitleColor(kSystemOriginColor, for: .highlighted)
            btn.frame = CGRect(x: CGFloat(index) * btnW, y: 0, width: btnW, height: 38)
//            btn.adjustsImageWhenDisabled = false
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(subTitleClick(_:)), for: .touchUpInside)
            self.addSubview(btn)
            btn.tag = index
            
            btnArray.append(btn)
            
            if index == 0 {
                lastBtn = btn
                subTitleClick(btn)
            }
        }
    }
}

// MARK: - 事件监听
extension LKSegmentVioew {
    
   @objc func subTitleClick(_ btn: UIButton) {
    
           btn.isSelected = true
           if lastBtn != btn {
                lastBtn.isSelected = false
                lastBtn = btn
            }
            sliderView.centerX = btn.centerX
            sliderView.snp.updateConstraints { (make) in
      
              make.width.equalTo((btn.titleLabel?.getStringWidth(string: (btn.titleLabel?.text)!,fontSize: 15))!)
              make.left.equalTo(btn.x + (btn.width - (btn.titleLabel?.getStringWidth(string: (btn.titleLabel?.text)!,fontSize: 15))!) / 2)
             }
    
            //实际上 ? 代替了OC中的responsed
            delegate?.segMentViewDidSelectedTitle(index: btn.tag)
        }
}

 // MARK: - 提供给外界ScollerView调用的方法
extension LKSegmentVioew {
    
    func changeSelectedBtn(btn: UIButton) {

        for item in btnArray{
            if item == btn {
                UIView.animate(withDuration: 0.3, animations: { 
                    
                    btn.isSelected = true
                    self.sliderView.centerX = btn.centerX
                    self.sliderView.snp.updateConstraints { (make) in
                        
                        make.width.equalTo((btn.titleLabel?.getStringWidth(string: (btn.titleLabel?.text)!,fontSize: 15))!)
                    }
                })

            }else {
                item.isSelected = false
            }
        }
    }
}
