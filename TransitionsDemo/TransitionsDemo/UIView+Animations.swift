//
//  UIView+Animations.swift
//  TransitionsDemo
//
//  Created by Gabriel Lanata on 13/8/18.
//  Copyright © 2018 Gabriel Lanata. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func shake(_ times: Int = 2, distance: CGFloat = 10) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.autoreverses = true
        animation.repeatCount = Float(times)
        animation.fromValue = CGPoint(x: self.center.x - distance, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + distance, y: self.center.y)
        self.layer.add(animation, forKey: "shake")
    }
    
    public func rotate(_ times: Int = 0, duration: Double = 0.5) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = duration
        animation.repeatCount = Float(times > 0 ? times : 10000)
        animation.toValue = Double.pi * 2
        self.layer.add(animation, forKey: "rotate")
        
    }
    
}
