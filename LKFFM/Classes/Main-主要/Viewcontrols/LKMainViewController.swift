//
//  LKMainViewController.swift
//  LKFFM
//
//  Created by Mike on 2017/1/11.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

// tag值的累积值
let kTagPlus: Int = 100
// TabBar的高度
let kTabBarH: CGFloat = 49

class LKMainViewController: UITabBarController {

    // MARK:- 懒加载
    
    /// 自定义tabbar的背景图片
    lazy var bgImageView: UIImageView = {
        let img = UIImageView.init()
        img.frame = CGRect(x: 0, y: kScreenH - kTabBarH, width: kScreenW, height: kTabBarH)
        img.image = UIImage.init(named: "tabbar_bg")
        img.isUserInteractionEnabled = true
        return img
    }()
    
    //正常状态的图片数组
    lazy var normalImageArray: [UIImage] = {
        // 定义一个可变数组,必须初始化才能使用
        var tempArray: [UIImage] = [UIImage]()
         // 可变数组添加数据
        tempArray.append(UIImage.init(named: "tabbar_find_n")!)
        tempArray.append(UIImage.init(named: "tabbar_sound_n")!)
        tempArray.append(UIImage.init(named: "tabbar_np_playnon")!)
        tempArray.append(UIImage.init(named: "tabbar_download_n")!)
        tempArray.append(UIImage.init(named: "tabbar_me_n")!)
        
        return tempArray
    }()
    
    //选中状态的图片数组
    lazy var selectedImageArray: [UIImage] = {
        var tempArray: [UIImage] = [UIImage]()
        
        tempArray.append(UIImage.init(named: "tabbar_find_h")!)
        tempArray.append(UIImage.init(named: "tabbar_sound_h")!)
        tempArray.append(UIImage.init(named: "tabbar_np_playnon")!)
        tempArray.append(UIImage.init(named: "tabbar_download_h")!)
        tempArray.append(UIImage.init(named: "tabbar_me_h")!)
        
        return tempArray
    }()
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 自定义TabBar
        createCustomTabBar()
        // 配置子控制器
        configSubControllers()
    }
}
// MARK:- 初始化
extension LKMainViewController {
    // MARK:- 自定义TabBar
    func createCustomTabBar() {
        // 隐藏原有TabBar
        tabBar.isHidden = true
        // 添加TabBar的背景图
        view.addSubview(bgImageView)
        
        let width: CGFloat = kScreenW / 5.0
        for index in 0..<5 {
            // 创建button
            let btn = UIButton.init(type: .custom)
            // 设置中间按钮坐标 突出显示
            if index == 2 {
                btn.frame = CGRect.init(x: kScreenW * 0.5 - kTabBarH * 0.5, y: -10, width: kTabBarH + 10, height: kTabBarH + 10)
            }else{
                btn.frame = CGRect.init(x: width * CGFloat(index), y: 0, width: width, height: kTabBarH)
            }
            btn.tag = kTagPlus + index
            btn.adjustsImageWhenHighlighted = false
            btn.setImage(normalImageArray[index], for: .normal)
            btn.setImage(selectedImageArray[index], for: .selected)
            btn.addTarget(self, action: #selector(tabBarItemSelected(_ :)), for: .touchUpInside)
            
            bgImageView.addSubview(btn)
        }
        
        // 设置中间按钮阴影
        guard let playBtn = bgImageView.viewWithTag(102) else {
            return
        }
        let imgView = UIImageView.init(image: UIImage.init(named: "tabbar_np_shadow"))
        let btnW: CGFloat = playBtn.width + 6
        imgView.frame = CGRect.init(x: -3, y: -3, width: btnW, height: btnW * 13.0 / 15.0)
        playBtn.addSubview(imgView)
        
        // 设置默认选中第一个
        tabBarItemSelected(bgImageView.viewWithTag(kTagPlus) as! UIButton)
    }
    
    // MARK:- 配置子控制器
    func configSubControllers() {
       
        //初始化一个可变数组
        var tempArray: [LKBaseNavigationController] = [LKBaseNavigationController]()
        
        let findVC = navigationControllerWith(LKFindViewController())
        let subScribeVC = navigationControllerWith(LKSubScribeViewController())
        let playVC = navigationControllerWith(LKPlayViewController())
        let downLoadVC = navigationControllerWith(LKDownLoadViewController())
        let mineVC = navigationControllerWith(LKMineViewController())
        
        // 添加控制器到数组
        tempArray.append(findVC)
        tempArray.append(subScribeVC)
        tempArray.append(playVC)
        tempArray.append(downLoadVC)
        tempArray.append(mineVC)
        
        viewControllers = tempArray
    }
    
    func navigationControllerWith(_ vc: UIViewController) -> LKBaseNavigationController {
        
        let nav = LKBaseNavigationController(rootViewController: vc)
        nav.delegate = self
        return nav
    }
}
// MARK:- NavigationController代理
extension LKMainViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
             bgImageView.isHidden = true
        }
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if !viewController.hidesBottomBarWhenPushed {
            bgImageView.isHidden = false
        }
    }
}
// MARK:- 事件监听
extension LKMainViewController {
    @objc func tabBarItemSelected(_ btn: UIButton) {
        btn.isSelected = true
        btn.isUserInteractionEnabled = false
        
        for subBtn in bgImageView.subviews {
            
            guard let xbtn = subBtn as? UIButton else {
              continue
            }
            if xbtn.tag == btn.tag {
                continue
            }
            xbtn.isSelected = false
            xbtn.isUserInteractionEnabled = true
        }
         // 当前选中按钮的tag
        let btnTag = btn.tag - kTagPlus
        if versionTabBarSelectedIndex(btnTag) {
            // 非播放按钮
            selectedIndex = btnTag
        }else {
            btn.isSelected = false
            btn.isUserInteractionEnabled = true
        }
        
    }
    
    /// 判断选中的是不是播放按钮
    func versionTabBarSelectedIndex(_ index: Int) -> Bool {
        if index == 2 {// 是播放界面
            // TODO:- 插播放界面
            let playVC = LKPlayViewController()
            let navi = LKBaseNavigationController(rootViewController: playVC)
            present(navi, animated: true, completion: nil)
            
            return false
        }
        return true
    }
}
