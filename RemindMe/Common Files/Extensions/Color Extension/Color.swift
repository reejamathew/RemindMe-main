//
//  Color.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-11-30.
//

import Foundation
import UIKit


extension UIColor {
    
    // Primary Color
    static var appPrimaryColor: UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    }
        
    //Light Greay color
    static var veryLightGray: UIColor
    {
        return UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    }

    
    public class var backgroundColor : UIColor{
        return  UIColor(named: "backgroundColor") ?? UIColor.white
    }
    
    public class var boxColor : UIColor{
        return  UIColor(named: "boxColor") ?? UIColor.white
    }
    
    public class var blackColor : UIColor{
        return  UIColor(named: "blackColor") ?? UIColor.white
    }

    public class var whiteColor : UIColor{
        return  UIColor(named: "whiteColor") ?? UIColor.white
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
