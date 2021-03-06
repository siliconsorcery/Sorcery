//
//  Stack.swift
//  Sorcery
//
//  Created by John Cumming on 11/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct Stack<Content: View>: View {
    
    public var body: some View {
        
        ZStack(alignment: aligmnent) {
            if expanded { FullFrame() }
            self.content
        }
    }
    
    public var content: Content
    
    var aligmnent: SwiftUI.Alignment
    var expanded: Bool
    
    public init(
        _ alignment: SwiftUI.Alignment = .center
        ,expanded: Bool = false
        ,@ViewBuilder build: () -> Content
    ) {
        self.content = build()
        self.aligmnent = alignment
        self.expanded = expanded
    }
    
}
