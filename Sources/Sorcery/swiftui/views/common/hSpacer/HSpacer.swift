//
//  HSpacer.swift
//  Sorcery
//
//  Created by John Cumming on 11/18/19.
//  Copyright © Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct HSpacer: View {
    
    public var body: some View {
        Spacer()
        .frame(width: width)
    }
    
    // MARK: - Optional

    var width: CGFloat

    public init(
        width: CGFloat = 16
    ) {
        self.width = width
    }
    
}
