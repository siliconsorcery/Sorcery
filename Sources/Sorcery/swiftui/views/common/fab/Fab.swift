//
//  FireList_Fab.swift
//  Sorcery
//
//  Created by John Cumming on 11/3/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct Fab: View {

    public var body: some View {
        backgroundColor
        .frame(width: 56, height: 56)
        .background(backgroundColor)
        .cornerRadius(36)
        .shadow(radius: 8)
        .overlay(
            Image(systemName: icon)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(foregroundColor)
        )
        
    }
    
    // MARK: - Optional
    
    private var icon: String
    private var backgroundColor = Color(UIColor.systemBackground)
    private var foregroundColor = Color(UIColor.link)
    
    public init(
        icon: String = "plus",
        backgroundColor: Color = Color(UIColor.systemBackground),
        foregroundColor: Color = Color(UIColor.link)
    ) {
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

}

// MARK: - Preview

//struct Fab_Previews: PreviewProvider {
//    static var previews: some View {
//        HStack {
//            Fab()
//
//            Fab(icon: "trash")
//        }
//    }
//}
