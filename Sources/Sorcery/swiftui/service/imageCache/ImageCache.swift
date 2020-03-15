//
//  ImageCache.swift
//  Sorcery
//
//  Created by John Cumming on 3/15/20.
//  Copyright © 2020 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import SwiftUI

class ImageCache {

    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {

    private static var imageCache = ImageCache()
    
    static func get() -> ImageCache {
        return imageCache
    }

}
