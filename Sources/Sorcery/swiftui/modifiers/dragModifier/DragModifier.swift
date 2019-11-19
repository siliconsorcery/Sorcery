//
//  DragModifier.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct DragModifier: ViewModifier {

    public func body(content: Content) -> some View {
        content
            .frame(width: 30, height: 4)
            .background(Color.red)
            .opacity(0.25)
            .cornerRadius(2)
            .padding([.top], 8)
    }
}

extension View {

    public func dragMod() -> some View {
        self.modifier(DragModifier())
    }
}
