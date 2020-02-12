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

    /// Create a UIColor from a rgb hexidecimal representation
    ///
    /// - Parameter rgb: int representation of color.
    ///  - Use hex '0x00FF00' for green
    ///  - Alpha is set to opaque ( Not transparent)
    public convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: 255
        )
    }

    /// Create a UIColor from a rgba hexidecimal string representation
    ///
    /// - Parameter:
    ///  hex: int representation of color.
    ///  - Use hex '00FF0080' for green with 50% alpha

    public convenience init(fromHex: String) {
        
        let r, g, b, a: CGFloat

        if fromHex.count == 8 {
            let scanner = Scanner(string: fromHex)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
            
        } else if fromHex.count == 6 {
            let scanner = Scanner(string: fromHex)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
                a = 0xFF

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }

        // BOGUS:
        self.init(ciColor: .red)
        return
    }

    /// Represent color as a hexidecimal string
    ///
    /// - Returns: hexidecimal string
    
    public func toHex() -> String {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgba = [r, g, b, a]
            .map { $0 * 255 }
            .reduce("", { $0 + String(format: "%02x", Int($1)) })
        
        return rgba.uppercased()
    }
}
