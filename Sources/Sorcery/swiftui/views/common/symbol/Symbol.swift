//
//  Symbol.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct Symbol: View {
    
    public var body: some View {
        let scale: UIImage.SymbolScale = .medium
        
        //        let adjustedSize = pointSize * 1.16667 * ((scale == .small) ? 0.8 : (scale == .large) ? 1.2 : 1.0)
        
        return Image(
            uiImage: UIImage(
                named: named,
                in: nil,
                with: UIImage.SymbolConfiguration(
                    pointSize: pointSize,
                    weight: .regular,
                    scale: scale
                )
                )!
                .withRenderingMode(.alwaysTemplate)
        )
        //        .resizable()
        //        .aspectRatio(1, contentMode: .fit)
        //        .frame(height: adjustedSize)
    }
    
    // MARK: - Required

    let named: String
    
    // MARK: - Optional

    let pointSize: CGFloat
    
    public init(
        named: String,
        pointSize: CGFloat = 24.0
    ) {
        self.named = named
        self.pointSize = pointSize
    }
}
