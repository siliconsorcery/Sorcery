//
//  Under-UX.swift
//  FWBY
//
//  Created by John Cumming on 6/9/20.
//  Copyright © 2020 Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct UnderModifier<ModifierContent: View>: ViewModifier {
    
    public func body(content: Content) -> some View {
        return content
            .background(modifierContent(), alignment: alignment)
    }
    
    // MARK: - Properties

    let alignment: SwiftUI.Alignment
    var modifierContent: () -> ModifierContent
}

extension View {
    
    public func under<ModifierContent: View>(
        _ alignment: SwiftUI.Alignment = .center
        ,@ViewBuilder modifierContent: @escaping () -> ModifierContent
    ) -> some View {
        
        self.modifier(
            UnderModifier(
                alignment: alignment
                ,modifierContent: modifierContent
            )
        )
        
    }
}
