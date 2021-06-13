//
//  CustomImageView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

let kImageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
	var imageUrlString: String?

	func loadImageFromUrlString(urlString: String) {
		imageUrlString = urlString
		let url = URL(string: urlString)
		if let imageFromCache = kImageCache.object(forKey: urlString as AnyObject) as? UIImage {
			self.image = imageFromCache
			return
		}

		URLSession.shared.dataTask(with: url!) { data, _, error in
			if (error != nil) {
				Log.notice("CustomImageView: \(String(describing: error))")
				return
			}
			Log.warning("BOGUS: Put this on a background thread!")
			let imageToCache = UIImage(data: data!)
			kImageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
			if (self.imageUrlString == urlString) {
				self.image = UIImage(data: data!)
			}
		}
        .resume()
	}
}
