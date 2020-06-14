//
//  Badge.swift
//  FWBY
//
//  Created by John Cumming on 5/24/20.
//  Copyright © 2020 Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct Badge: View {
    
    let text: String
    let color: Color
    
    public init(
        text: String? = nil
        ,color: Color? = nil
    ) {
        self.text = text ?? ""
        self.color = color ?? Color.red
    }
    
    public var body: some View {
        Group {
            if text.isEmpty {
                Circle()
                    .foregroundColor(color)
                    .frame(width: 8, height: 8)
            } else {
                Text(text)
                    .font(.system(size: 10))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 1)
                    .foregroundColor(Color.white)
                    .background(color)
                    .cornerRadius(8)
                    .frame(height: 16)
//                    .shadow(radius: 2)
            }
        }
    }
}
