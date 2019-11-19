//
//  VSpacer.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct VSpacer: View {
    
    public var body: some View {
        Spacer()
        .frame(height: height)
    }
    
    // MARK: - Optional

    var height: CGFloat
    
    public init(
        height: CGFloat = 16
    ) {
        self.height = height
    }
    
}
