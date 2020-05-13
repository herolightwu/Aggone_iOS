//
//  CircularProgressView.swift
//  Aggone
//
//  Created by MeiXiang Wu on 5/5/20.
//  Copyright © 2020 tiexiong. All rights reserved.
//

import UIKit

@IBDesignable
class CircularProgressView: UIView {
// First create two layer properties
     var bgPathTopLevel:UIBezierPath!
       var topLevelShapeLayer:CAShapeLayer!
       var topLevelProgressLayer:CAShapeLayer!
       var progressText:UILabel!
       
       @IBInspectable var showProgressText:Bool = false
       
      @IBInspectable var outerProgress:CGFloat = 0 {
           willSet(newValue) {
               
               let animation = CABasicAnimation(keyPath: "strokeEnd")
               animation.fromValue = outerProgress
               animation.toValue = newValue
               animation.duration = 0
               animation.duration = 0.5
               topLevelProgressLayer.add(animation, forKey: "drawLineAnimation")
               
           }
       }
       
       @IBInspectable var progress:CGFloat = 0.0 {
           willSet (newValue) {
               if showProgressText {
                   var preogressStr = ""
                   
                   if (0 ... 1).contains(newValue){
                       
                       preogressStr = String.init(format: "%d%@", Int(newValue*100),"%")
                   }else {
                       preogressStr = String.init(format: "%d%@", 100,"%")
                   }
                   self.progressText.text = preogressStr
               }
             
               
           }
       }
       @IBInspectable var outerThickness:CGFloat  = 5.0{
           willSet(newValue){
               topLevelShapeLayer.lineWidth = newValue
               topLevelProgressLayer.lineWidth = newValue
               
           }
       }
       
       @IBInspectable var outerProgressColor:UIColor = UIColor.blue {
           willSet(newValue){
               topLevelProgressLayer.strokeColor = newValue.cgColor
               
           }
       }
       
       @IBInspectable public var thickness:CGFloat = 5
       
       override init(frame: CGRect) {
           super .init(frame: frame)
           simpleShape()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           simpleShape()
       }
       
       override func draw(_ rect: CGRect) {
           self.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi/2) * -1));
           self.backgroundColor = UIColor.clear
           simpleShape()
       }
       private func createCirclePath() {
           let x = self.bounds.width/2
           let y = self.bounds.height/2
           
           let center = CGPoint(x: x, y: y)
           
           bgPathTopLevel = UIBezierPath.init()
           
           bgPathTopLevel.addArc(withCenter: center, radius: x-10, startAngle: CGFloat(0), endAngle: CGFloat(2*(Double.pi)), clockwise: true)
           
           bgPathTopLevel.close()
           
           if showProgressText {
               progressText = UILabel.init(frame: CGRect.init(x: 0, y: 0, width:(x-25) * 2, height: (x-25) * 2))
               progressText.textColor = UIColor.black
               progressText.text = "0%"
               progressText.textAlignment = .center
               self.addSubview(progressText)
               progressText.backgroundColor = UIColor.clear
               progressText.center = center
               progressText.font = UIFont.systemFont(ofSize:(x-25)/2 )
               progressText.transform = CGAffineTransform(rotationAngle: CGFloat((Double.pi/2)));
           }
           
       }
       
       
       func simpleShape() {
           createCirclePath()
           
           topLevelShapeLayer = CAShapeLayer()
           topLevelShapeLayer.path = bgPathTopLevel.cgPath
           topLevelShapeLayer.lineWidth = outerThickness
           topLevelShapeLayer.fillColor = nil
        topLevelShapeLayer.strokeColor = UIColor.from(hex: "#E0E0E0").cgColor //UIColor.lightGray.cgColor
           
           topLevelProgressLayer = CAShapeLayer()
           topLevelProgressLayer.path = bgPathTopLevel.cgPath
           topLevelProgressLayer.lineWidth = outerThickness
           topLevelProgressLayer.lineCap = "round"
           topLevelProgressLayer.fillColor = nil
           topLevelProgressLayer.strokeColor = outerProgressColor.cgColor
           topLevelProgressLayer.strokeEnd = outerProgress
           
           self.layer.addSublayer(topLevelShapeLayer)
           self.layer.addSublayer(topLevelProgressLayer)
           
        }
}
