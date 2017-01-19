//
//  LKPlayViewController.swift
//  LKFFM
//
//  Created by Mike on 2017/1/11.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

class LKPlayViewController: LKBaseViewController {

    /// 单利
    static let shareInstancd = LKPlayViewController()
//    static let shareInstancd: LKPlayViewController = {
//        let playVC = LKPlayViewController()
//        return playVC
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏
        configNavigationBar()
    }

}

// MARK: - 设置导航栏
extension LKPlayViewController {
    
    func configNavigationBar() {
        // 左侧按钮
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftBtn.setImage(UIImage.init(named: "btn_back_n"), for: .normal)
        leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        leftBtn.addTarget(self, action: #selector(btnClicked(_ :)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        //右侧按钮
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightBtn.setImage(UIImage(named: "icon_share_h"), for: .normal)
        rightBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        rightBtn.addTarget(self, action: #selector(shareBtnClick(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
}

// MARK: - 事件监听
extension LKPlayViewController {
    // MARK:- 左侧按钮
    @objc func btnClicked(_ btn: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    // MARK:- 右侧按钮
    @objc func shareBtnClick(_ btn: UIButton) {
        LKLog("shareBtnClick")
    }
}
