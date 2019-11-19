//
//  EdgeReveal.swift
//  Sorcery
//
//  Created by John Cumming on 11/17/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct EdgeReveal<Content: View>: View {
    
    public var body: some View {
        
        let progress = reveal.progress(edge)
        
        let offset = closed + delta() * CGFloat(progress)
        
        return GeometryReader { _ in
            // Fade background
            Color
            .black
            .opacity(0.5 * progress)
            .edgesIgnoringSafeArea(.all)
            .gesture(
                TapGesture()
                .onEnded {
                    self.reveal.reset(self.edge)
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
                        self.reveal.set(self.edge, progress: self.newProgress(dragX: drag.translation.width))
                    } else {
                        self.startProgress = self.reveal.progress(self.edge)
                        self.isDragging = true
                    }
                }
                .onEnded { drag in
                    self.isDragging = false
                    self.startProgress = 0.0
                    self.reveal.set(
                        self.edge,
                        progress: (self.newProgress(dragX: drag.predictedEndTranslation.width) > 0.5) ? 1.0 : 0.0
                    )

                }
                .simultaneously(
                    with: TapGesture()
                    .onEnded {
                        self.reveal.toggle(self.edge)
                    }
                )
            )
        }
        .animation(.spring())
    }
    
    // MARK: - Required
    
    @EnvironmentObject private var reveal: EdgeRevealModel
    
    public var content: Content
    public var edge: EdgeRevealModel.Edge
    
    // MARK: - Optional
    
    var width: CGFloat
        
    public init(
        width: CGFloat = 300.0,
        edge: EdgeRevealModel.Edge = .left,
        @ViewBuilder build: () -> Content
    ) {
        self.content = build()
        self.width = width
        self.edge = edge
        
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
            reveal.snap(edge)
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

public final class EdgeRevealModel: ObservableObject {
    
    @Published private var progressRight: Double = 0.0
    @Published private var progressLeft: Double = 0.0
    
    public init() {}
    
    // MARK: - Public
    
    public enum Edge {
        case left, right
    }
    
    public func progress(_ edge: Edge) -> Double {
        if (edge == .right) {
            return progressRight
        } else {
            return progressLeft
        }
    }
    
    public func set(_ edge: Edge, progress: Double) {
        if (edge == .right) {
            progressRight = progress
        } else {
            progressLeft = progress
        }
    }
    
    public func reset(_ edge: Edge) {
        if (edge == .right) {
            progressRight = 0.0
        } else {
            progressLeft = 0.0
        }
    }

    public func toggle(_ edge: Edge) {
        if (edge == .right) {
            progressRight = toggle(progressRight)
        } else {
            progressLeft = toggle(progressLeft)
        }
    }
    
    public func snap(_ edge: Edge) {
        if (edge == .right) {
            progressRight = snap(progressRight)
        } else {
            progressLeft = snap(progressLeft)
        }
    }
    
    // MARK: - Private
    
    private func toggle(_ value: Double) -> Double {
        (value > 0.5) ? 0.0 : 1.0
    }
    
    private func snap(_ value: Double) -> Double {
        var value = value
        if (value > 0.9) {
            value = 0.0
        } else if (value < 0.1) {
            value = 1.0
        } else {
            value = (value > 0.5) ? 1.0 : 0.0
        }
        return value
    }
    
}

// MARK: - Preview

struct EdgeReveal_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ZStack {
            Color.green

            EdgeReveal { Color.red }

            EdgeReveal(width: 300, edge: .right) { Color.blue }
        }
        .environmentObject(EdgeRevealModel())
        .edgesIgnoringSafeArea(.all)
    }
}
