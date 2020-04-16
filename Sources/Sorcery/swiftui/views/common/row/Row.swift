//
//  Row.swift
//  Sorcery
//
//  Created by John Cumming on 11/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct Row<Content: View>: View {
    
    public var body: some View {
                        
        let horizontal = tight ? .center : self.horizontal
        
        return VStack(alignment: horizontal, spacing: spacing) {
            if (vertical == .bottom) {
                Spacer(minLength: 0)
            }
            
            HStack(alignment: vertical, spacing: spacing) {
                if (horizontal == .trailing) {
                    Spacer(minLength: 0)
                }
                
                content
                
                if (horizontal == .leading) {
                    Spacer(minLength: 0)
                }
            }
            
            if (vertical == .top) {
                Spacer(minLength: 0)
            }
        }
    }
    
    // MARK: - Required
    
    public var content: Content
    
    // MARK: - Optional
    
    var horizontal: SwiftUI.HorizontalAlignment = .center
    var vertical: SwiftUI.VerticalAlignment = .center
    var tight: Bool
    var spacing: CGFloat?
    
    public init(
        _ alignment: SwiftUI.Alignment = .center,
        tight: Bool = false,
        spacing: CGFloat? = nil,
        @ViewBuilder build: () -> Content
    ) {
        self.tight = tight
        self.spacing = spacing
        self.content = build()
        
        self.horizontal = horizontalAlignment(from: alignment)
        self.vertical = verticalAlignment(from: alignment)
    }
    
    private func horizontalAlignment(from alignment: SwiftUI.Alignment) -> SwiftUI.HorizontalAlignment {
        if (alignment == .topLeading || alignment == .leading || alignment == .bottomLeading) {
            return .leading
        } else if (alignment == .topTrailing || alignment == .trailing || alignment == .bottomTrailing) {
            return .trailing
        } else {
            return .center
        }
    }
    
    private func verticalAlignment(from alignment: SwiftUI.Alignment) -> SwiftUI.VerticalAlignment {
        if (alignment == .topLeading || alignment == .top || alignment == .topTrailing) {
            return .top
        } else if (alignment == .bottomLeading || alignment == .bottom || alignment == .bottomTrailing) {
            return .bottom
        } else {
            return .center
        }
    }
    
}
