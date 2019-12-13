//
//  SystemSymbol.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct SystemSymbol: View {

    public var body: some View {
        Image(
            uiImage: UIImage(
                systemName: named,
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: pointSize,
                    weight: .regular,
                    scale: .medium
                )
            )!
            .withRenderingMode(.alwaysTemplate)
        )
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
