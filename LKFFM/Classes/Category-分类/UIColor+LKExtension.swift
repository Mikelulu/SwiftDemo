//
//  UIColor+LKExtension.swift
//  LKFFM
//
//  Created by Mike on 2017/1/11.
//  Copyright © 2017年 LK. All rights reserved.
//

import Foundation
import UIKit

/**
 1、通过实例或者对象调用的方法称为实例方法
 
 2、类方法只能用类型名称（结构体类型名/类名）调用
 
 3、static或者class修饰的函数，称其为类方法，class修饰函数只能类中使用
 
 4、结构体实例方法可以直接访问结构体的成员变量
 
 5、结构体的类方法默认不能访问结构体中的成员变量
 
 6、实例方法可以直接调用其他实例方法，调用类方法可以直接使用类名调用
 
 7、类方法中可以直接调用其他类方法，不能直接调用实例方法
 */
extension UIColor {
    
    class func hexInt(_ hexValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                       
                       green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                       
                       blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                       
                       alpha: 1.0)
        
    }
}
