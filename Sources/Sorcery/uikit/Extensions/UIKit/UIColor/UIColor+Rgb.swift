//
//  UIColor+Rgb.swift
//  firebase
//
//  Created by John Cumming on 8/30/18.
//  Copyright © 2018 Booth Hill Software, Inc. All rights reserved.
//

import UIKit

extension UIColor {

    /// Create a UIColor from interger RGBA components.
    ///
    /// - Parameters:
    ///   - red: red value ( 0 - 255 )
    ///   - green: green value ( 0 - 255 )
    ///   - blue: blue value ( 0 - 255 )
    ///   - alpha: alpha value ( 0 - 255 )
    public convenience init(
        red: Int,
        green: Int,
        blue: Int,
        alpha: Int
    ) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0 && alpha <= 255, "Invalid alpha component")

        self.init(
            red: CGFloat(red) / 255.0
            ,green: CGFloat(green) / 255.0
            ,blue: CGFloat(blue) / 255.0
            ,alpha: CGFloat(alpha) / 255.0
        )
    }

    /// Create a UIColor from a rgba hexidecimal representation
    ///
    /// - Parameter rgb: int representation of color.
    ///  - Use hex '0x00FF00' for green
    ///  - Use hex '0x00FF0080' for green with aplha of 50%
    public convenience init(rgb: Int) {
        if (rgb > 0xFFFFFF) {
            self.init(
                red: (rgb >> 24) & 0xFF,
                green: (rgb >> 16) & 0xFF,
                blue: (rgb >> 8) & 0xFF,
                alpha: rgb & 0xFF
            )
        } else {
            self.init(
                red: (rgb >> 16) & 0xFF,
                green: (rgb >> 8) & 0xFF,
                blue: rgb & 0xFF,
                alpha: 255
            )
        }
    }

    /// Represent color as a hexidecimal string
    ///
    /// - Parameter isUppercased: true, return will be in uppercase
    /// - Returns: hexidecimal string
    public func toRGBString(isUppercased: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb = [r, g, b, a]
            .map { $0 * 255 }
            .reduce("", { $0 + String(format: "%02x", Int($1)) })
        return isUppercased ? rgb.uppercased() : rgb
    }
}
