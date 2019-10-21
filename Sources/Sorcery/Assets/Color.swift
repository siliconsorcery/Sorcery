//
//  Color.swift
//  Sorcery
//
//  Created by John Cumming on 11/16/17.
//  Copyright © 2017 Silicon Sorcery. All rights reserved.
//

import UIKit

/// Lossely based on MaterialColors and subdividing the spectrum
public enum Color {
    
    static let clear = UIColor.clear

    // Usefull hints about naming colors: https://www.color-blindness.com/color-name-hue/

    // Use UIColor.ligtness(CFFloat)
    // Lighter version eg. color.ligtness(0.1)
    // Darker version eg. color.ligtness(-0.1)

    // TASK: Rework colors to use HSL
    // eg: static let red = UIColor.init(hue: 0, saturation: 1.0, lightness: 0.5)

    // Base color subdivisions
    // Approx: (Hue: Color, Saturation: 1.0, Lightness: 0.5)

    public static let red = UIColor(rgb: 0xF44336)
    public static let orange = UIColor(rgb: 0xFF9800)
    public static let yellow = UIColor(rgb: 0xFFEB3B)
    public static let lime = UIColor(rgb: 0xCDDC39)
    public static let green = UIColor(rgb: 0x4CAF50)
    public static let teal = UIColor(rgb: 0x009688)
    public static let cyan = UIColor(rgb: 0x00BCD4)
    public static let sapphire = UIColor(rgb: 0x03A9F4)
    public static let blue = UIColor(rgb: 0x2196F3)
    public static let indigo = UIColor(rgb: 0x3F51B5)
    public static let magenta = UIColor(rgb: 0x9C27B0)
    public static let pink = UIColor(rgb: 0xE91E63)

    // Additional convience colors

    public static let scarlet = UIColor(rgb: 0xFF5722)
    public static let amber = UIColor(rgb: 0xFFC107)
    public static let neon = UIColor(rgb: 0x8BC34A)
    public static let violet = UIColor(rgb: 0x673AB7)
    public static let purple = UIColor(rgb: 0x9C27B0)
    public static let brown = UIColor(rgb: 0x795548)

    // Non color colors!

    public static let white = UIColor(rgb: 0xFFFFFF)
    public static let gray = UIColor(rgb: 0x9E9E9E)
    public static let blueGray = UIColor(rgb: 0x607D8B)
    public static let black = UIColor(rgb: 0x000000)
}
