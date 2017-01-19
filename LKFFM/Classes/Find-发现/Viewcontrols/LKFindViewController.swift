//
//  LKFindViewController.swift
//  LKFFM
//
//  Created by Mike on 2017/1/11.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
import SVProgressHUD

class LKFindViewController: LKBaseViewController {

    var bannerArr = Array<BannerModel>()
    var tableViewArray = Array<UITableView>()
    
    // MARK:- 懒加载
    
    lazy var bannerView: LKBannerView = {
       let banner = LKBannerView()
       return banner
    }()
    
    lazy var segmentView: LKSegmentVioew = {
        let view = LKSegmentVioew()
        return view
    }()
    
    lazy var bgScrollerView: UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.delegate = self
        scrollerView.isPagingEnabled = true
        scrollerView.bounces = false
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.contentSize = CGSize(width: kScreenW * 5, height: 0)
        return scrollerView
    }()
    
    
    // MARK:- 生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       navigationController?.navigationBar.setBackGroundColor(UIColor.clear)
       navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        self.navigationController?.navigationBar.alpha = 0
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
       title = "发现"
        
        //添加子视图
        addSubViews()
        
        //设置子视图的坐标
        layoutSubViews()
        
        //网络请求banner数据
        getBannerData()
        
        //添加子控制器
        addSunVCs()
        
        showVC(0)
        showVC(1)
        showVC(2)
        showVC(3)
        showVC(4)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let tableView = object as! UITableView
        
        if !(keyPath == "contentOffset") {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        let tableViewoffsetY = tableView.contentOffset.y
        LKLog(tableViewoffsetY)
        
        let color: UIColor = UIColor(colorLiteralRed: 0/225.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
        
        if tableViewoffsetY > 50 {
            let alpha: CGFloat = 1 - (50 + 64 - tableViewoffsetY) > 1 ? 1 : 1 - (50 + 64 - tableViewoffsetY)
            navigationController?.navigationBar.setBackGroundColor(color.withAlphaComponent(alpha))
        }else {
            navigationController?.navigationBar.setBackGroundColor(color.withAlphaComponent(0))
        }
        if tableViewoffsetY >= 0 && tableViewoffsetY <= 150{
            self.bannerView.frame = CGRect(x: 0, y: 0 - tableViewoffsetY, width: kScreenW, height: 150)
            self.segmentView.frame = CGRect(x: 0, y: 150 - tableViewoffsetY, width: kScreenW, height: 40)
            self.bgScrollerView.frame = CGRect(x: 0, y: 190 - tableViewoffsetY, width: kScreenW, height: kScreenH - 64 - 49 - 40)
           
        }
        else if tableViewoffsetY > 150 {
            self.segmentView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 40)
            self.bannerView.frame = CGRect(x: 0, y: -150 , width: kScreenW, height: 150)
            self.bgScrollerView.frame = CGRect(x: 0, y: 40, width: kScreenW, height: kScreenH - 64 - 49 - 40)
        }else if tableViewoffsetY < 0 {
            
            self.segmentView.frame = CGRect(x: 0, y: 150, width: kScreenW, height: 40)
            self.bannerView.frame = CGRect(x: 0, y: 0 , width: kScreenW, height: 150)
            self.bgScrollerView.frame = CGRect(x: 0, y: 190, width: kScreenW, height: kScreenH - 64 - 49 - 190)
        }
    }
}

// MARK: - 子视图
extension LKFindViewController {
    //添加子视图
    func addSubViews() {
        
       view.addSubview(bgScrollerView)
       view.addSubview(bannerView)
        
       view.addSubview(segmentView)
       segmentView.titleArray = ["推荐","分类","广播","榜单","主播"]
       segmentView.delegate = self
    }
    
    //设置子视图的坐标
    func layoutSubViews() {
        
        bannerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(150)
        }
        
        segmentView.snp.makeConstraints { (make) in
            make.top.equalTo(bannerView.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }
        
        bgScrollerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.segmentView.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom).offset(-49)
        }
    }
    
    //添加子控制
    func addSunVCs() {
        let recommendVC = LKRecommendViewController()
        let categoryVC = LKCategoryViewController()
        let radioVC = LKRadioViewController()
        let randVC = LKRandViewController()
        let anchorVC = LKAnchorViewController()
        
        self.addChildViewController(recommendVC)
        self.addChildViewController(categoryVC)
        self.addChildViewController(radioVC)
        self.addChildViewController(randVC)
        self.addChildViewController(anchorVC)
        
        tableViewArray.append(recommendVC.tableView)
        tableViewArray.append(categoryVC.tableView)
        tableViewArray.append(radioVC.tableView)
        tableViewArray.append(randVC.tableView)
        tableViewArray.append(anchorVC.tableView)
        
        for tableView in tableViewArray {
            tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        }
    }
    
    // 显示控制器的view
    func showVC(_ index:NSInteger){
        let offset:CGFloat = CGFloat(index) * kScreenW
        
        let vc:UIViewController = self.childViewControllers[index]
        if vc.isViewLoaded {
            return
        }
        
        self.bgScrollerView.addSubview(vc.view)
        vc.view.frame = CGRect(x: offset, y: 0, width: kScreenW, height: self.bgScrollerView.height)
    }
}

// MARK: - LKSegmentVioewDelegate
extension LKFindViewController : LKSegmentVioewDelegate {
    
    func segMentViewDidSelectedTitle(index: NSInteger) {
        
       showVC(index)
        
        let offset: CGFloat = CGFloat(index) * kScreenW
        self.bgScrollerView.contentOffset = CGPoint(x: offset, y: 0)
        
    }
}

// MARK: - UIScrollViewDelegate
extension LKFindViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index:NSInteger = NSInteger(scrollView.contentOffset.x / kScreenW)
        showVC(index)
        
        let btn: UIButton = self.segmentView.btnArray[index]
        self.segmentView.changeSelectedBtn(btn: btn)
    }
}
// MARK: - 网络请求
extension LKFindViewController {
    //banner
    func getBannerData() {
        
        SVProgressHUD.show()
        let url = "http://mobile.ximalaya.com/mobile/discovery/v4/recommends?"
        let params = [
            "channel" : "ios-b1",
            "device"  : "iPhone",
            "includeActivity" : "true",
            "includeSpecial"  : "true",
            "scale" : "2",
            "version" : "5.4.21"
        ]
        
        LKNetworkManager.sharedInstance.getRequest(urlString: url, params: params) { (response, error) in
            
            
            SVProgressHUD.dismiss()
            if (response != nil) {
                
                let json = JSON(response!)
                //LKLog(json)
                //遍历数组
                for (_,subJson) : (String,JSON) in json["focusImages"]["list"] {
                    
                    let model = BannerModel.init(dic: subJson)
                    self.bannerArr.append(model)
                }
                self.bannerView.getScrollImgSource(source: self.bannerArr)
            }
        }
    }
}
