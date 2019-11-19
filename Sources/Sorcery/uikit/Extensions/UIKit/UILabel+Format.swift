//
//  UILabel.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import UIKit

extension UILabel {
    /// Changes the views properties based on the provided format and the current theme
    ///
    /// - Parameter format: [Assets.Format] enum to be applied
    /// - Returns: returns self to allow for chaining
//    @discardableResult
//    func format(_ format: Assets.Format) -> UILabel {
//        let theme = ThemeManager.get().theme
//        switch format {
//        case .h1:
//            self.font = theme.h1Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h2:
//            self.font = theme.h2Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h3:
//            self.font = theme.h3Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h4:
//            self.font = theme.h4Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h5:
//            self.font = theme.h5Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h6:
//            self.font = theme.h6Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .title:
//            self.font = theme.titleFont
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .subtitle:
//            self.font = theme.subtitleFont
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .body:
//            self.font = theme.bodyFont
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .small:
//            self.font = theme.smallFont
//            self.textAlignment = .left
//            self.textColor = theme.inkAltColor
//            self.backgroundColor = UIColor.clear
//
//        case .tiny:
//            self.font = theme.tinyFont
//            self.textAlignment = .left
//            self.textColor = theme.inkAltColor
//            self.backgroundColor = UIColor.clear
//        }
//        return self
//    }

    /// Set alignment
    ///
    /// - Parameter align: use of the following: .left, .right, .center, .justified, .natural
    /// - Returns: returns self to allow for chaining
    @discardableResult
    func align(_ align: NSTextAlignment) -> UILabel {
        let label = self
        label.textAlignment = align
        return label
    }

    /// Set text color
    ///
    /// - Parameter color: text color
    /// - Returns: return self to allow chaining
    @discardableResult
    func color(_ color: UIColor) -> UILabel {
        let label = self
        label.textColor = color
        return label
    }

    /// Set character spacing
    /// BOGUS: Assumes text can be converted to attributedText
    ///
    /// - Parameter value: spacing
    /// - Returns: return self to allow chaining
    @discardableResult
    func charactersSpacing(_ characterSpacing: CGFloat = -1.5) -> UILabel {
        let label = self

        if let string = label.text {
            let attributes: [NSAttributedString.Key: Any] = [
                .kern: characterSpacing
            ]
            label.attributedText = NSAttributedString(string: string, attributes: attributes)
        }

        return label
    }
}
