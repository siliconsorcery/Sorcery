//
//  Pad.swift
//  Sorcery
//
//  Created by John Cumming on 4/9/20.
//  Copyright © Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct Pad: View {
    
    public var body: some View {
        return Spacer()
            .frame(width: width, height: height)
    }
    
    // MARK: - Properties

    var width: CGFloat
    var height: CGFloat
    
    public init(
        width: CGFloat = 16
        ,height: CGFloat = 16
    ) {
        self.width = width
        self.height = height
    }
}
