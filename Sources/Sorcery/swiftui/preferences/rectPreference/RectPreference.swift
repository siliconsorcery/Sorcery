//
//  RectPreference.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct RectData: Equatable {
    public let id: Int
    public let rect: CGRect
}

public struct RectPreferenceKey: PreferenceKey {
    public typealias Value = [RectData]
    
    public static var defaultValue: [RectData] = []
    
    public static func reduce(
        value: inout [RectData],
        nextValue: () -> [RectData]
    ) {
        value.append(contentsOf: nextValue())
    }
}

public struct RectFor: View {
    
    public var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(
                    key: RectPreferenceKey.self,
                    value: [
                        RectData(
                            id: self.id,
                            rect: geometry.frame( in: .global )
                        )
                    ]
            )
        }
    }
    
    // MARK: - Required

    let id: Int
}

public struct RectPreferenceModifier: ViewModifier {

    public func body(content: Content) -> some View {
        return content
            .background(RectFor(id: id))
    }
    
    // MARK: - Required

    var id: Int
}

extension View {
    
    public func rectPreference(id: Int) -> some View {
        self.modifier(RectPreferenceModifier(id: id))
    }
}
