//
//  ViewController.swift
//  Aggone
//
//  Created by tiexiong on 3/19/19.
//  Copyright © 2019 tiexiong. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func deltaTimeString(delta: Int64)->String {
        let min = delta / 60
        let hour = min / 60
        let day = hour / 24
        if (day > 30) {
            return ""
        }
        if (day > 0) {
            return "\(day)" + " days ago"
        }
        if (hour > 0) {
            return "\(hour)" + " hours ago"
        }
        if (min == 0) {
            return "Now"
        }
        return "\(min)" + " mins ago"
    }
    
    static func AnyToInt(value: Any)->Int {
        guard let val = value as? String else {
           return value as! Int
        }
        return Int(val)!
    }
    
    static func AnyToInt64(value: Any)->Int64 {
        guard let val = value as? String else {
            return value as! Int64
        }
        return Int64(val)!
    }
    
    static func formatNumber(_ n: Int) -> String {

        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""

        switch num {

        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.truncate(places: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(n)"

        default:
            return "\(sign)\(n)"

        }

    }
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in:rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
}

extension Double {

    func truncate(places: Int) -> Double {

        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal

    }

}
