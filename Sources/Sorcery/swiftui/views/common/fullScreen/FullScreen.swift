//
//  FullScreen.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct FullScreen<Content: View>: View {
    
    public var body: some View {
        Stack {
            color
            .edgesIgnoringSafeArea(.all)
            
            content
        }
    }
    
    // MARK: - Required

    var content: Content
    
    // MARK: - Optional

    var color: SwiftUI.Color
    
    public init(
        color: SwiftUI.Color = Color(UIColor.systemBackground),
        @ViewBuilder content: () -> Content
    ) {
        self.color = color
        self.content = content()
    }
}
