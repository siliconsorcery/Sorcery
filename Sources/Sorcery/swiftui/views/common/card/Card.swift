//
//  Card.swift
//  Sorcery
//
//  Created by John Cumming on 11/15/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

public struct Card: View {

    public var body: some View {
        Column {
            Image(props.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.yellow)
         
            Row(.leading) {
                Column(.leading) {
                    Text(props.category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(props.heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    
                    Text(props.author.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
            }
            .padding()
        }
        .contextMenu {
            Button(action: { Log.task() }) {
                Row {
                    Text("One")
                    Image(systemName: "paperplane")
                }
            }
            
            Button(action: { Log.task() }) {
                Row {
                    Image(systemName: "tray")
                    Text("Two")
                }
            }
            
            Button(action: { Log.task() }) {
                Row {
                    Text("Three")
                    Image(systemName: "folder")
                }
            }
        }
        .background(Color.white)
        .cornerRadius(12.0)
        .padding(.horizontal, 16.0)
        .shadow(radius: 8.0)
    }
    
    // MARK: - Required
    
    var props: CardModel
    
    public init(
        props: CardModel
    ) {
        self.props = props
    }
    
}

public struct CardModel: Identifiable {
    
    // MARK: - Optional
    
    public var id: UUID
    
    // MARK: - Required
    
    public var image: String
    public var category: String
    public var heading: String
    public var author: String
    
    public init(
        id: UUID? = nil,
        image: String,
        category: String,
        heading: String,
        author: String
    ) {
        self.id = id ?? UUID()
        self.image = image
        self.category = category
        self.heading = heading
        self.author = author
    }
}
