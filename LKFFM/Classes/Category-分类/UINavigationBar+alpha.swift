//
//  UINavigationBar+alpha.swift
//  LKFFM
//
//  Created by Mike on 2017/1/18.
//  Copyright © 2017年 LK. All rights reserved.
//

import Foundation
import UIKit

private struct AssociatedKeys {
    static var backImageKey: UIView?
}
extension UINavigationBar {

    var backImage: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.backImageKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.backImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setBackGroundColor(_ color: UIColor) {
        if (self.backImage == nil) {
            self.setBackgroundImage(UIImage(), for: .default)
            self.backImage = UIView(frame: CGRect(x: 0, y: -20, width: self.width, height: 64))
            self.backImage?.isUserInteractionEnabled = false
            self.backImage?.autoresizingMask = .flexibleWidth
            
//            self.subviews.first?.insertSubview(self.backImage!, at: 0)
            self.insertSubview(self.backImage!, at: 0)
        }
        self.backImage?.backgroundColor = color
    }
}
