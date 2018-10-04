//
//  UIColor+rgb.swift
//  Rook Card Demo
//
//  Created by Steve Liddle on 10/4/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

extension Int {
    var rgbComponent: CGFloat {
        return CGFloat(self) / 255.0
    }
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: r.rgbComponent, green: g.rgbComponent, blue: b.rgbComponent, alpha: 1.0)
    }
}
