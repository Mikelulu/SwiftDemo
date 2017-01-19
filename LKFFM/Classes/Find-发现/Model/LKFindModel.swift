//
//  LKFindModel.swift
//  LKFFM
//
//  Created by Mike on 2017/1/12.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit
import SwiftyJSON

class LKFindModel: NSObject {

}


class BannerModel: NSObject {
    
    var pic = String()
    
    init(dic: JSON) {
        self.pic = dic["pic"].stringValue
    }
}
