//
//  Avatar.swift
//  FWBY
//
//  Created by John Cumming on 2/22/20.
//  Copyright © 2020 Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct Avatar: View {
    
    public var body: some View {
        let props = map()
        
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
                        Text(verbatim: props.alt)
                        .font(.system(size: self.size(geometry)))
                        .bold()
                        .fixedSize()
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
            
    // MARK: - Properties
    
    var color: Color = .white
    var activeColor = Color(UIColor.link)
    var image: Image?
    var icon: Image?
    var alt: String = "??"
    
    public init(
        color: Color? = nil
        ,activeColor: Color? = nil
        ,image: Image? = nil
        ,icon: Image? = nil
        ,alt: String? = nil
    ) {
        self.color = color ?? .white
        self.activeColor = activeColor ?? Color(UIColor.link)
        self.image = image
        self.icon = icon
        self.alt = alt ?? "??"
    }
    
    private struct Props {
        let color: Color
        let activeColor: Color
        var image: Image?
        var icon: Image?
        var alt: String
        let hasImage: Bool
        let hasIcon: Bool
    }
    
    private func map() -> Props {
        return Props(
            color: self.color
            ,activeColor: (self.color == Color.white) ? self.activeColor : Color.white
            ,image: self.image
            ,icon: self.icon
            ,alt: self.alt
            ,hasImage: (self.image != nil)
            ,hasIcon: (self.icon != nil)
        )
    }
    
    private func size(_ geometry: GeometryProxy) -> CGFloat {
        min(geometry.size.height * 0.4, geometry.size.width * 0.4)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        
        Column {
            
            Row {
                Avatar(alt: "AB").frame(height: 24)
                Avatar(alt: "JC").frame(height: 24)
                Avatar(color: Color.red, alt: "JC").frame(height: 24)
                Avatar(alt: "JC").frame(height: 24)
            }
            
            Row {
                Avatar(color: Color.red, alt: "SW").frame(width: 24, height: 24)
                Avatar(color: Color.white, alt: "SW").frame(width: 40, height: 40)
                Avatar(color: Color.blue, alt: "SW").frame(width: 80, height: 80)
            }
            
            Row {
                Avatar(color: Color.red, icon: Image(systemName: "person")).frame(width: 24, height: 24)
                Avatar(color: Color.white, icon: Image(systemName: "person")).frame(width: 40, height: 40)
                Avatar(color: Color.blue, icon: Image(systemName: "person")).frame(width: 80, height: 80)
            }
            
            Row {
                Avatar(color: Color.red, image: Image("named-logo")).frame(width: 24, height: 24)
                Avatar(color: Color.white, image: Image("named-logo")).frame(width: 48, height: 48)
                Avatar(color: Color.blue, image: Image("named-logo")).frame(width: 80, height: 80)
            }
            Avatar(alt: "JC").frame(height: 50)
            Avatar(color: Color.red, alt: "JC").frame(height: 50)
            Avatar(color: Color.red, icon: Image(systemName: "person")).frame(height: 50)
            Avatar(color: Color.red, image: Image("background")).frame(height: 50)

            Row {
                Avatar(alt: "JC")
                Avatar(icon: Image(systemName: "person"))
                Avatar(image: Image("background"))
            }
        }
        .padding(.horizontal, 16)
        .shadow(radius: 4)
    }
}
