//
//  UIColor+Rgb.swift
//  firebase
//
//  Created by John Cumming on 8/30/18.
//  Copyright © 2018 Booth Hill Software, Inc. All rights reserved.
//

import UIKit

extension UIColor {
    /// Create a UIColor from CGFloat RGB components
    ///
    /// - Parameters:
    ///   - r: red value
    ///   - g: green value
    ///   - b: blue value
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }

    /// Create a UIColor from interger RGB components.
    ///
    /// - Parameters:
    ///   - red: red value ( 0 - 255 )
    ///   - green: green value ( 0 - 255 )
    ///   - blue: blue value ( 0 - 255 )
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    /// Create a UIColor from a rgb hexidecimal representation
    ///
    /// - Parameter rgb: int representation of color. Use hex '0x00FF00' for green
    public convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    /// Represent color as a hexidecimal string
    ///
    /// - Parameter isUppercased: true, return will be in uppercase
    /// - Returns: hexidecimal string
    func toRGBString(isUppercased: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb = [r, g, b]
            .map { $0 * 255 }
            .reduce("", { $0 + String(format: "%02x", Int($1)) })
        return isUppercased ? rgb.uppercased() : rgb
    }
}
