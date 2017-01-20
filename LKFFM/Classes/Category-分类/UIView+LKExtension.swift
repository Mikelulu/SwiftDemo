//
//  UIView+LKExtension.swift
//  LKFFM
//
//  Created by Mike on 2017/1/11.
//  Copyright © 2017年 LK. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// 裁剪 view 的圆角
    ///
    /// - parameter direction:    裁剪哪一个角
    /// - parameter cornerRadius: 圆角值
    func clipRectCorner(direction: UIRectCorner,cornerRadius: CGFloat) {
        let cornerSize = CGSize.init(width: cornerRadius, height: cornerRadius)
        //贝塞尔
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskShapLayer = CAShapeLayer.init()
        maskShapLayer.frame = bounds
        maskShapLayer.path = maskPath.cgPath
        layer.addSublayer(maskShapLayer)
        layer.mask = maskShapLayer
    }
    
    // MARK:- 
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var tempFrame = self.frame
            tempFrame.origin.x = newValue
            self.frame = tempFrame
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var tempFrame = self.frame
            tempFrame.origin.y = newValue
            self.frame = tempFrame
        }
    }
    
    /// 右边界的x值
    public var rightX: CGFloat{
        get{
            return self.x + self.width
        }
        set{
            var r = self.frame
            r.origin.x = newValue - frame.size.width
            self.frame = r
        }
    }
    /// 下边界的y值
    public var bottomY: CGFloat{
        get{
            return self.y + self.height
        }
        set{
            var r = self.frame
            r.origin.y = newValue - frame.size.height
            self.frame = r
        }
    }
    
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            self.width = newValue.width
            self.height = newValue.height
        }
    }
}

extension UILabel {
    func getStringWidth(string: String, fontSize: CGFloat) -> CGFloat {
        
     let rect = string.boundingRect(with: CGSize.init(width: Double(MAXFLOAT), height: 10), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil)
        return CGFloat(ceilf(Float(rect.width)))

    }
}
extension String {
    func getStringHeight(string: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        
        let rect = string.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil)
        return CGFloat(ceil(Float(rect.height)))
    }
}
