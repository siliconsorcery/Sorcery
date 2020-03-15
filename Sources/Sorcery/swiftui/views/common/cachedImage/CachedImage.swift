//
//  CachedImage.swift
//  FWBY
//
//  Created by John Cumming on 3/14/20.
//  Copyright © 2020 Silicon Sorcery. All rights reserved.
//

import SwiftUI

public struct CachedImage: View {

    public var body: some View {
        Image(
            uiImage: imageLoader.image ?? defaultImage
        )
        .resizable()
        .scaledToFit()
    }
    
    @ObservedObject var imageLoader: ImageLoader
    let defaultImage: UIImage
    
    public init(
        for url: String? = nil
        ,defaultImage: UIImage? = nil
    ) {
        self.defaultImage = defaultImage ?? UIImage(named: "placeholderImage") ?? UIImage()
        imageLoader = ImageLoader(url: url)
    }
    
}
