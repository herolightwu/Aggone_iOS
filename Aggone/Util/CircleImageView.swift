//
//  CircleImageView.swift
//  Aggone
//
//  Created by MeiXiang Wu on 4/9/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

class CircleImageView : UIView {
    
    var image: UIImage! {
        didSet {
            self.addLayers()
        }
    }
    
    override var frame: CGRect {
        didSet {
            self.addLayers()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(image:UIImage) {
        self.init(frame: CGRect(origin: .zero, size: image.size))
        self.image = image
        self.addLayers()
    }
    
    private func addLayers(){
        print("in add layers")
        if image == nil {
            return
        }
        self.layer.sublayers?.removeAll()
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.layer.frame.width/2
        
        let shadowL = CALayer()
        shadowL.shadowColor = UIColor.gray.cgColor
        shadowL.frame = self.layer.bounds.insetBy(dx: 2, dy: 2)
        shadowL.shadowOpacity = 0.7
        shadowL.shadowRadius = 2
        shadowL.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shadowL.cornerRadius = shadowL.frame.width/2
        shadowL.borderWidth = 0
        shadowL.borderColor = UIColor.clear.cgColor
        shadowL.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(shadowL)
        
        let newL = CALayer()
        newL.frame = shadowL.bounds
        newL.backgroundColor = UIColor.clear.cgColor
        newL.cornerRadius = newL.frame.width/2
        newL.contents = self.image.cgImage
        newL.masksToBounds = true
        shadowL.addSublayer(newL)
    }
}
