//
//  Double-Interpolate.swift
//  App
//
//  Created by John Cumming on 11/10/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import SwiftUI

extension Double {
    
    public func interpolate(
        to: Double,
        in fraction: Double,
        min: Double = 0,
        max: Double = 1
    ) -> Double {
        if fraction <= min {
            return self
        } else if fraction >= max {
            return to
        }
        return self + (to - self) * (fraction - min) / (max - min)
    }
}
