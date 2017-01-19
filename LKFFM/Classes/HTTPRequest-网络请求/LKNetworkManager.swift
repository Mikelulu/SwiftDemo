//
//  LKNetworkManager.swift
//  LKFFM
//
//  Created by Mike on 2017/1/12.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class LKNetworkManager: NSObject {

    //单利
//    static let sharedInstance = LKNetworkManager()
    
    //
    static let sharedInstance: LKNetworkManager = {
        let manger = LKNetworkManager()
        return manger
    }()
}

extension LKNetworkManager {
    
    func getRequest(urlString: String,params: [String : Any],finished : @escaping (_ response : [String : AnyObject]?, _ error:NSError?) ->()) {
        
       Alamofire.request(urlString, method: .get, parameters: params).responseJSON { (response) in
        
             if response.result.isSuccess {
                
                finished(response.result.value as? [String : AnyObject], nil)
             }else{
                SVProgressHUD.showError(withStatus: "网络连接失败")
                finished(nil, response.result.error as NSError?)
             }
 
        }
    }
    
    func postRequest(urlString: String, params : [String : Any], finished : @escaping (_ response : [String : AnyObject]?,_ error: NSError?)->()) {
        
        
        Alamofire.request(urlString, method: .post, parameters: params)
            .responseJSON { (response) in
                
                if response.result.isSuccess{
                    
                    finished(response.result.value as? [String : AnyObject],nil)
                }else{
                    
                    finished(nil,response.result.error as NSError?)
                    
                }
        }
    }

    
}
