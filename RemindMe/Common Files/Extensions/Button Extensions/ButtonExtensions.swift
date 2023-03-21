//
//  ButtonExtensions.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-11-30.
//

import Foundation
import UIKit

extension UIButton {
    
    //Set button
    func setBothCorner() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
    //Set button border with color
    func setBorderwithColor(borderColor: UIColor, textColor: UIColor, backGroundColor: UIColor, borderWidth: CGFloat){
        self.setTitleColor(textColor, for: .normal)
        self.layer.borderColor = borderColor.cgColor
        self.backgroundColor = backGroundColor
        self.layer.borderWidth = borderWidth
    }
    
    //Set button text color
    func textColor(color: UIColor) {
        self.setTitleColor(color, for: .normal)
    }
    
    func centerVertically(padding: CGFloat = 6.0) {
        guard let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        let imageYpos = (self.frame.size.height / 2) - (imageViewSize.height/2) - titleLabelSize.height
        self.imageEdgeInsets = UIEdgeInsets(
            top: imageYpos,
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: (imageYpos + imageViewSize.height),
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
       
    func changeToRight(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    //Set Image spance with button
    func setImageTitle(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    class func CustomButton(target: AnyObject?, selector: Selector?) -> UIButton {
        
        let button = UIButton.init(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        if target != nil && selector != nil {
            button.addTarget(target, action: selector!, for: .touchUpInside)
        }
        return button
    }
}
