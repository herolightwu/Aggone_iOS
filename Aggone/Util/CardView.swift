//
//  CardView.swift
//  Aggone
//
//  Created by tiexiong on 5/23/18.
//  Copyright © 2018 tiexiong. All rights reserved.
//

import UIKit

class CardView: UIView {
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowOpacity: Float = 0.2
    @IBInspectable var cornerRadius: Float = 2
    
    override func layoutSubviews() {
        layer.cornerRadius = CGFloat(cornerRadius)
        clipsToBounds = true
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width:shadowOffsetWidth, height:shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
    }
}
