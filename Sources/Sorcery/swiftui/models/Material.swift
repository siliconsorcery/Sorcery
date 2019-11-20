//
//  Color.swift
//  App
//
//  Created by John Cumming on 11/3/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public enum Material {
    
    // Base color subdivisions
    // Approx: (Hue: Color, Saturation: 1.0, Lightness: 0.5)

    public static let red = Color(hex: "0xF44336")
    public static let orange = Color(hex: "0xFF9800")
    public static let yellow = Color(hex: "0xFFEB3B")
    public static let lime = Color(hex: "0xCDDC39")
    public static let green = Color(hex: "0x4CAF50")
    public static let teal = Color(hex: "0x009688")
    public static let cyan = Color(hex: "0x00BCD4")
    public static let sapphire = Color(hex: "0x03A9F4")
    public static let blue = Color(hex: "0x2196F3")
    public static let indigo = Color(hex: "0x3F51B5")
    public static let magenta = Color(hex: "0x9C27B0")
    public static let pink = Color(hex: "0xE91E63")

    // Additional convience colors

    public static let scarlet = Color(hex: "0xFF5722")
    public static let amber = Color(hex: "0xFFC107")
    public static let neon = Color(hex: "0x8BC34A")
    public static let violet = Color(hex: "0x673AB7")
    public static let purple = Color(hex: "0x9C27B0")
    public static let brown = Color(hex: "0x795548")

    // Non color colors!

    public static let white = Color(hex: "0xFFFFFF")
    public static let gray = Color(hex: "0x9E9E9E")
    public static let blueGray = Color(hex: "0x607D8B")
    public static let black = Color(hex: "0x000000")
    
}
