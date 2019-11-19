//
//  Int-Ff.swift
//  App
//
//  Created by John Cumming on 11/10/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

extension Int {
    
    public func ff(_ shift: Int) -> Double {
        return Double((self >> shift) & 0xff) / 255
    }
}
