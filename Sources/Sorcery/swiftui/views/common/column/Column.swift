//
//  Column.swift
//  Sorcery
//
//  Created by John Cumming on 11/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct Column<Content: View>: View {
    
    public var body: some View {
        
        let vertical = tight ? .center : self.vertical
        
        return HStack(alignment: vertical, spacing: horizontalSpacing) {
            if (horizontal == .trailing) {
                Spacer(minLength: 0)
            }
            
            VStack(alignment: horizontal, spacing: verticalSpacing) {
                if (vertical == .bottom) {
                    Spacer(minLength: 0)
                }
                
                content
                
                if (vertical == .top) {
                    Spacer(minLength: 0)
                }
            }
            
            if (horizontal == .leading) {
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
    var horizontalSpacing: CGFloat?
    var verticalSpacing: CGFloat?
    
    public init(
        _ alignment: SwiftUI.Alignment = .center
        ,horizontal: SwiftUI.HorizontalAlignment? = nil
        ,vertical: SwiftUI.VerticalAlignment? = nil
        ,tight: Bool = false
        ,spacing: CGFloat? = nil
        ,@ViewBuilder build: () -> Content
    ) {
        self.tight = tight
        self.content = build()
        
        if horizontal == nil && vertical == nil {
            self.horizontalSpacing = spacing
            self.verticalSpacing = spacing
        }
        if horizontal != nil {
            self.horizontalSpacing = spacing
        }
        if vertical != nil {
            self.verticalSpacing = spacing
        }
        
        self.horizontal = (horizontal != nil)
            ? horizontal!
            : horizontalAlignment(from: alignment)
        
        self.vertical = (vertical != nil)
            ? vertical!
            : verticalAlignment(from: alignment)
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
