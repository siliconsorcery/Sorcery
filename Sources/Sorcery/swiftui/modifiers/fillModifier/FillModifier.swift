//
//  FillModifier.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct FillModifier: ViewModifier {

    public func body(content: Content) -> some View {
        return content
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
        )
            .background(color)
            .edgesIgnoringSafeArea(.all)
    }

    // MARK: - Required

    var color: SwiftUI.Color

}

extension View {
    
    public func filled(color: SwiftUI.Color = .white) -> some View {
        self.modifier(FillModifier(color: color))
    }
}
