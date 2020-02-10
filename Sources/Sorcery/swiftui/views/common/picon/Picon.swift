//
//  Picon.swift
//  Sorcery
//
//  Created by John Cumming on 11/16/19.
//  Copyright © Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct Picon: View {
    
    public var body: some View {
            
        let props = Props(
            color: self.color,
            activeColor: (self.color == Color.white) ? self.activeColor : Color.white,
            image: self.image,
            icon: self.icon,
            alt: self.alt,
            hasImage: (self.image != nil),
            hasIcon: (self.icon != nil)
        )
        
        return GeometryReader { outer in
            GeometryReader { geometry in
                Stack {
                    if props.hasImage {
                        props.image!
                        .resizable()
                        .scaledToFill()
                    }
                    
                    if !props.hasImage && props.hasIcon {
                        props.icon!
                        .resizable()
                        .frame(width: self.size(geometry), height: self.size(geometry))
                        .scaledToFill()
                    }
                    
                    if !props.hasImage && !props.hasIcon {
                        Text(props.alt)
                        .font(.system(size: self.size(geometry)))
                        .bold()
                    }
                }
            }
            .foregroundColor(props.activeColor)
            .background(props.color)
            .cornerRadius(1000)
            .overlay(
                RoundedRectangle(cornerRadius: 1000)
                    .stroke(Color.white, lineWidth: max(2, self.size(outer) * 0.15))
                    .opacity(props.hasImage ? 1 : 0)
            )
        }
    }
            
    // MARK: - Optional
    
    var color: Color
    var activeColor: Color
    var image: Image?
    var icon: Image?
    var alt: String

    public init(
        color: Color = Color.white,
        activeColor: Color = Color(UIColor.link),
        image: Image? = nil,
        icon: Image? = nil,
        alt: String = "??"
    ) {
        self.color = color
        self.activeColor = activeColor
        self.image = image
        self.icon = icon
        self.alt = alt
    }
    
    // MARK: - Props
    
    struct Props {
        let color: Color
        let activeColor: Color
        var image: Image?
        var icon: Image?
        var alt: String
        let hasImage: Bool
        let hasIcon: Bool
    }

    // MARK: - Private
    
    private func size(_ geometry: GeometryProxy) -> CGFloat {
        min(geometry.size.height * 0.4, geometry.size.width * 0.4)
    }
}

// MARK: - Preview

struct Picon_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
            HStack {
                Picon(alt: "AB").frame(height: 24)
                Picon(alt: "JC").frame(height: 24)
                Picon(color: Color.red, alt: "JC").frame(height: 24)
                Picon(alt: "JC").frame(height: 24)
            }
            
            HStack {
                Picon(color: Color.red, icon: Image(systemName: "person")).frame(width: 24, height: 24)
                Picon(color: Color.white, icon: Image(systemName: "person")).frame(width: 48, height: 48)
                Picon(color: Color.blue, icon: Image(systemName: "person")).frame(width: 100, height: 100)
            }
            
            HStack {
                Picon(color: Color.red, image: Image("sushi")).frame(width: 24, height: 24)
                Picon(color: Color.white, image: Image("sushi")).frame(width: 48, height: 48)
                Picon(color: Color.blue, image: Image("sushi")).frame(width: 100, height: 100)
            }
            Picon(alt: "JC").frame(height: 50)
            Picon(color: Color.red, alt: "JC").frame(height: 50)
            Picon(color: Color.red, icon: Image(systemName: "person")).frame(height: 50)
            Picon(color: Color.red, image: Image("sushi")).frame(height: 50)

            HStack {
                Picon(alt: "JC")
                Picon(icon: Image(systemName: "person"))
                Picon(image: Image("sushi"))
            }
        }
        .padding(.horizontal, 16)
        .shadow(radius: 4)
    }
}
