//
//  DragModifier.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct HintModifier: ViewModifier {

    public func body(content: Content) -> some View {
        let props = map()
        
        return content
            .frame(width: 30, height: 4)
            .background(props.key)
            .opacity(0.25)
            .cornerRadius(2)
            .padding([.top], 8)
    }
    
    let key: Color

    private struct Props {
        let key: Color
    }
    
    private func map() -> Props {
        return Props(
            key: key
        )
    }
    
}

extension View {

    public func dragHint(key: Color) -> some View {
        self.modifier(HintModifier(key: key))
    }
}
