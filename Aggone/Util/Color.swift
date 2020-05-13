//
//  Color.swift
//  Marifa
//
//  Created by tiexiong on 2/28/18.
//  Copyright © 2018 zhang. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    class func from(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func random() -> UIColor {
        return UIColor(red:   CGFloat(arc4random()) / CGFloat(UInt32.max),
                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       blue:  CGFloat(arc4random()) / CGFloat(UInt32.max),
                       alpha: 1.0)
    }
}

let primaryColor = UIColor.from(hex:"#82BF3F")
let priDarkColor = UIColor.from(hex:"#008598")
let whiteColor = UIColor.from(hex:"#FFFFFF")
let bgColor = UIColor.from(hex:"#FBFBFC")
