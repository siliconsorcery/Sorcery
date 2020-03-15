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
        let props = map()
        
        return Column {
            CachedImage(for: props.image)
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
                    
                    if props.description.isEmpty == false {
                        Text(props.description)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                    Text(props.author)
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
    
    // MARK: - Properties

    public var model: Model
    
    public init(_ model: Model) {
        self.model = model
    }
    
    public struct Model: Identifiable {
        
        public var id: UUID
        
        public var image: String
        public var category: String
        public var heading: String
        public var description: String
        public var author: String
        
        public init(
            id: UUID? = nil
            ,image: String
            ,category: String
            ,heading: String
            ,description: String
            ,author: String
        ) {
            self.id = id ?? UUID()
            self.image = image
            self.category = category
            self.heading = heading
            self.description = description
            self.author = author
        }
    }
    
    private struct Props {
        let image: String
        let category: String
        let heading: String
        let description: String
        let author: String
    }
    
    private func map() -> Props {
        return Props(
            image: model.image
            ,category: model.category
            ,heading: model.heading
            ,description: model.description
            ,author: model.author.uppercased()
        )
    }

}
