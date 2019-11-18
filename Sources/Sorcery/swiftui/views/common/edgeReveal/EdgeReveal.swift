//
//  EdgeReveal.swift
//  Sorcery
//
//  Created by John Cumming on 11/17/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct EdgeReveal<Content: View>: View {
    
    public var body: some View {
        
        let offset = closed + delta() * CGFloat(progress)
        
        return GeometryReader { _ in
            // Fade background
            Color
            .black
            .opacity(0.5 * self.progress)
            .edgesIgnoringSafeArea(.all)
            .gesture(
                TapGesture()
                .onEnded {
                    self.progress = 0.0
                }
            )
            
            Group {
                // Edge trigger
                Color
                .black
                .opacity(0.001)
                .frame(width: self.triggerXSize)
                .offset(x: self.triggerX)

                // Content
                self.content
                .frame(width: self.width)
                .offset(x: offset)
                .shadow(radius: 4)
            }
            .gesture(
                DragGesture()
                .onChanged { drag in
                    if self.isDragging {
                        self.progress = self.newProgress(dragX: drag.translation.width)
                    } else {
                        self.startProgress = self.progress
                        self.isDragging = true
                    }
                }
                .onEnded { drag in
                    self.isDragging = false
                    self.startProgress = 0.0
                    self.progress = (self.newProgress(dragX: drag.predictedEndTranslation.width) > 0.5) ? 1.0 : 0.0
                }
                .simultaneously(
                    with: TapGesture()
                    .onEnded {
                        self.toggleProgress()
                    }
                )
            )
        }
        .animation(.spring())
    }
    
    // MARK: - Required
    
    public var content: Content
    @Binding var progress: Double
    
    // MARK: - Optional
    
    var width: CGFloat
    
    public enum Edge {
        case left, right
    }
        
    public init(
        width: CGFloat = 300.0,
        edge: Edge = .left,
        progress: Binding<Double>,
        @ViewBuilder build: () -> Content
    ) {
        self.content = build()
        self.width = width
        self._progress = progress
        
        if (edge == .left) {
            self.opened = 0
            self.closed = -width
            self.triggerX = 0
        } else {
            self.opened = UIScreen.main.bounds.width - width
            self.closed = UIScreen.main.bounds.width
            self.triggerX = UIScreen.main.bounds.width - self.triggerXSize
        }
        
    }
    
    // MARK: - Private
    
    private var opened: CGFloat
    private var closed: CGFloat
    private var triggerX: CGFloat
    private let triggerXSize: CGFloat = 16

    @State private var isDragging = false
    @State private var startProgress = 0.0
    
    private func delta() -> CGFloat {
        opened - closed
    }
    
    private func toggleProgress() {
        withAnimation(
            Animation.spring(
                response: 0.5,
                dampingFraction: 0.5,
                blendDuration: 0.5
            )
        ) {
            if self.progress > 0.9 {
                self.progress = 0.0
            } else if self.progress < 0.1 {
                self.progress = 1.0
            } else {
                self.progress = (self.progress > 0.5) ? 1.0 : 0.0
            }
        }
    }
    
    private func newProgress(dragX: CGFloat) -> Double {
        if startProgress == 0.0 {
               return startProgress + min(1, Double(dragX / delta()))
           } else {
               return startProgress + min(0, Double(dragX / delta()))
           }
    }
}

// MARK: - Preview

struct EdgeReveal_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ZStack {
            Color.green

            EdgeReveal(progress: .constant(0.5)) { Color.red }

            EdgeReveal(width: 300, edge: .right, progress: .constant(0.0)) { Color.blue }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
