//
//  DialogFrame.swift
//  Sorcery
//
//  Created by John Cumming on 4/12/20.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct DialogFrame<Content: View>: View {
    
    public var body: some View {
        let props = map()
        
        return Stack {
            
            // Backdrop, close target
            Color(Material.black)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture { props.close() }
            
            // Content
            GeometryReader { context in
                                     
                Stack(props.alignment, expanded: true) {
                                   
                    Column(.top, spacing: 0) {
                        
                        // Title and Close
                        Row {
                            Text(props.title)
                                .foregroundColor(props.headerInk)
                                .font(props.body)
                                .fixedSize()
                                .accessibility(addTraits: .isHeader)

                            Spacer()

                            CloseButton(action: { props.close() })

                        }
                        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 8))
                        .background(props.headerPaper)

                        Divider()

                        // Content
                        SwiftUI.ScrollView {
                            Pad(height: 4)

                            self.content

                            Pad(height: 6)
                        }
                    }
                    .frame(
                        idealWidth: props.idealWidthRatio == nil
                            ? props.size != nil ? props.size!.width : nil
                            : context.size.width * props.idealWidthRatio!
                        
                        ,idealHeight: props.idealHeightRatio == nil
                            ? props.size != nil ? props.size!.height : nil
                            : context.size.height * props.idealHeightRatio!
                        ,alignment: .top
                    )
                    .fixedSize()
                    .background(props.paper)
                    .cornerRadius(props.corner)
                    .shadow(radius: props.shadow)
                    .offset(props.offset)
                }
            }
        }
    }

    // MARK: - Properties
    
    public let title: String
    public let closeAction: () -> Void
    
    public let alignment: SwiftUI.Alignment
    public let offset: CGSize
    public let size: CGSize?
    public let idealWidthRatio: CGFloat?
    public let idealHeightRatio: CGFloat?
    
    public let content: Content
    
    public init(
        title: String
        ,closeAction: @escaping () -> Void
        
        ,alignment: SwiftUI.Alignment? = nil
        ,offset: CGSize? = nil
        ,size: CGSize? = nil
        ,idealWidthRatio: CGFloat? = nil
        ,idealHeightRatio: CGFloat? = nil
        
        ,@ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.closeAction = closeAction
        
        self.alignment = alignment ?? .center
        self.offset = offset ?? CGSize()
        self.size = size
        self.idealWidthRatio = idealWidthRatio
        self.idealHeightRatio = idealHeightRatio
        
        self.content = content()
    }
    
    private struct Props {
        let title: String
        
        let paper: Color
        let ink: Color
        let inkAlt: Color
        let key: Color
        
        let body: Font
        
        let corner: CGFloat
        let shadow: CGFloat
        
        let headerPaper: Color
        let headerInk: Color
        
        let alignment: SwiftUI.Alignment
        let offset: CGSize
        
        let size: CGSize?
        let idealWidthRatio: CGFloat?
        let idealHeightRatio: CGFloat?

        let close: () -> Void
    }
    
    private func map() -> Props {
        
        return Props(
            title: title
            ,paper: Color(Material.white)
            ,ink: Color(Material.black)
            ,inkAlt: Color(Material.black.lightness(0.5))
            ,key: Color(Material.sapphire)
            
            ,body: Font(buildSystemFont(style: .headline, size: 15, weight: .regular))
            
            ,corner: 12.0
            ,shadow: 2.0
            
            ,headerPaper: Color(Material.white)
            ,headerInk: Color(Material.black.lightness(0.5))
            
            ,alignment: alignment
            ,offset: offset

            ,size: size
            ,idealWidthRatio: idealWidthRatio
            ,idealHeightRatio: idealHeightRatio
            
            ,close: closeAction
        )
    }
    
    private func buildSystemFont(style: UIFont.TextStyle, size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontMetrics = UIFontMetrics(forTextStyle: style)
        return fontMetrics.scaledFont(for: UIFont.systemFont(ofSize: size, weight: weight))
    }
}

public struct CloseButton: View {
    
    public var body: some View {
        let props = map()
        
        return Button(action: action) {
            Circle()
                .fill(Color.clear)
                .frame(width: 26, height: 26)
                .overlay(
                    Image(systemName: props.icon)
                        .foregroundColor(props.key)
                )
        }
        .accessibility(label: Text("Close"))
    }
    
    private struct Props {
        let key: Color
        let background: Color
        let icon: String
    }
    
    private func map() -> Props {
        
        return Props(
            key: Color(Material.sapphire)
            ,background: Color(Material.gray).opacity(0.25)
            ,icon: "plus"
        )
    }
    
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
}
