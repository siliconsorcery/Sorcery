//
//  Tap.swift
//  FWBY
//
//  Created by John Cumming on 5/25/20.
//  Copyright © 2020 Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct TapModifier: ViewModifier {

    let action: () -> Void
    
    public func body(content: Content) -> some View {
        
        return content
            .overlay(
                Color(Material.white).opacity(0.001)
                    .onTapGesture(perform: action)
            )
    }
}

extension View {
    public func tap(action: @escaping () -> Void) -> some View {
        self.modifier(TapModifier(action: action))
    }
}
