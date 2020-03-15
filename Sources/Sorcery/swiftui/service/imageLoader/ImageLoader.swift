//
//  ImageLoader.swift
//  Sorcery
//
//  Created by John Cumming on 3/15/20.
//  Copyright © 2020 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import SwiftUI

public class ImageLoader: ObservableObject {
    
    @Published public var image: UIImage?
    
    var url: String?
    var imageCache = ImageCache.get()
    
    public init(url: String?) {
        self.url = url
        load()
    }
    
    public func load() {
        if cached() { return }
        loadUrl()
    }
    
    func cached() -> Bool {
        guard let url = url else { return false }
        guard let cacheImage = imageCache.get(forKey: url) else { return false }
        image = cacheImage
        return true
    }
    
    func loadUrl() {
        guard let url = url else { return }
       
        if let image = UIImage(named: url) {
            self.imageCache.set(forKey: url, image: image)
            self.image = image
        } else {
            if let imageUrl = URL(string: url) {
                let task = URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                    guard error == nil else {
                        Log.error("Error: \(error!)")
                        return
                    }
                    guard let data = data else {
                        Log.warn("No data found")
                        return
                    }
                    DispatchQueue.main.async {
                        guard let image = UIImage(data: data) else { return }
                        self.imageCache.set(forKey: url, image: image)
                        self.image = image
                    }
                }
                task.resume()
            }
        }
    }
}
