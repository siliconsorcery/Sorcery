//
//  UIColor+Light.swift
//  firelist
//
//  Created by John Cumming on 1/12/19.
//  Copyright © 2019 Booth Hill Software, Inc. All rights reserved.
//

import UIKit

extension UIColor {
    /// Makes a new color by keeping the hue, saturation and reserving the lightness
    ///
    /// - Returns: new reversed lightness color
    public func reverseLightness() -> UIColor {
        let (hue, saturation, lightness) = hsl
        let newLightness = (1.0 - lightness) * ((lightness > 0.5) ? 0.5 : 1.0)
        return UIColor(hue: hue, saturation: saturation, lightness: newLightness)
    }

    /// Set the lightness of the color
    ///
    /// - Parameter lightnessAmount: 1.0(White) > 0.0(Color) > -1.0(Black)
    /// - Returns: new color
    public func lightness(_ lightnessAmount: CGFloat) -> UIColor {
        assert((-1...1).contains(lightnessAmount), "lightnessAmount value must be a value between -1.0 and 1.0")
        let (hue, saturation, _) = hsl
        let newLightness = 0.5 + lightnessAmount / 2
        return UIColor(hue: hue, saturation: saturation, lightness: newLightness)
    }

    public func saturation(_ saturationAmount: CGFloat) -> UIColor {
        assert((0...1).contains(saturationAmount), "saturationAmount value must be a value between -1.0 and 1.0")
        let (hue, _, lightness) = hsl
        let newSaturation = saturationAmount
        return UIColor(hue: hue, saturation: newSaturation, lightness: lightness)
    }

    public func shift(lightness lightenAmount: CGFloat, saturation saturationAmount: CGFloat? = nil) -> UIColor {
        let (hue, saturation, lightness) = hsl

        return UIColor(
            hue: hue,
            saturation: (saturationAmount == nil) ? saturation : saturation * (1.0 + saturationAmount!),
            lightness: lightness * (1.0 + lightenAmount),
            alpha: rgba.a
        )
    }

    /// Determines if the color is dark
    /// Consider the color to be dark if the grayScale value falls below a freehold
    public var isDark: Bool {
        var isDark = false
        var grayScale: CGFloat = 0.0
        var alphaScale: CGFloat = 0.0
        getWhite(&grayScale, alpha: &alphaScale)
        if (grayScale < 0.65) {
            isDark = true
        }
        return isDark
    }
}
