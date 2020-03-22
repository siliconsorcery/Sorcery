//
//  View+TypeErasure.swift
//  Sorcery
//  
//
//  Created by John Cumming on 3/22/20.
//  Copyright © 2020 Silicon Sorcery. All rights reserved.
//

import SwiftUI

extension View {
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
