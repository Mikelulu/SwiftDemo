//
//  LKBaseNavigationController.swift
//  LKFFM
//
//  Created by Mike on 2017/1/11.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit

class LKBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 隐藏返回按钮
       navigationItem.hidesBackButton = true
       
        let attributes = [
            NSForegroundColorAttributeName : UIColor.hexInt(0x333333),
            NSFontAttributeName: UIFont.systemFont(ofSize: 18)
        ]
        
        // 设置属性
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().tintColor = UIColor.hexInt(0x333333)
        
        // 设置返回图片
        let img = UIImage(named: "btn_back_n")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 18, 0, 0))
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: .default) // 让导航条返回键带的title消失!
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(img, for: .normal, barMetrics: .default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
