//
//  UIImage_Tint.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

extension UIImage {
    public func tinted(with color: UIColor) -> UIImage? {
        if let maskImage = cgImage {
            let width = size.width
            let height = size.height
            let bounds = CGRect(x: 0, y: 0, width: width, height: height)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
            let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

            context.clip(to: bounds, mask: maskImage)
            context.setFillColor(color.cgColor)
            context.fill(bounds)

            if let cgImage = context.makeImage() {
                let coloredImage = UIImage(cgImage: cgImage)
                return coloredImage
            } else {
                return nil
            }
        }
        return nil
    }

    public func tint(with color: UIColor) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)

        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: cgImage)
        color.setFill()
        context.fill(rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }

        UIGraphicsEndImageContext()
        return newImage
    }
}
