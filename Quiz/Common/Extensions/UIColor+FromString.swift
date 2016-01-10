//
//  UIColor+FromString.swift
//  Quiz
//
//  Created by Rafal Szastok on 10/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(dRed: UInt, dGreen: UInt, dBlue: UInt, dAlpha:UInt) {
        assert( dRed <= 255, "Invalid red component")
        assert( dGreen <= 255, "Invalid green component")
        assert( dBlue <= 255, "Invalid blue component")
        assert( dAlpha <= 255, "Invalid alpha component")
        
        self.init(
            red: CGFloat(dRed) / 255.0,
            green: CGFloat(dGreen) / 255.0,
            blue: CGFloat(dBlue) / 255.0,
            alpha: CGFloat(dAlpha)/255)
    }
    
    convenience init(netHex:UInt) {
        assert(((netHex>>24) & 0xFF) != 0, "Alpha cannot be zero")
        self.init(
            dRed:   (netHex>>16) & 0xFF,
            dGreen: (netHex >> 8) & 0xFF,
            dBlue:  netHex & 0xFF,
            dAlpha: (netHex>>24) & 0xFF)
    }
}