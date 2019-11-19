//
//  Color-Hex.swift
//  App
//
//  Created by John Cumming on 11/10/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import SwiftUI

extension Color {
    
    public init(hex: Int) {
        self.init(
            red: hex.ff(16),
            green: hex.ff(08),
            blue: hex.ff(00)
        )
    }
    
    public init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
    
}
