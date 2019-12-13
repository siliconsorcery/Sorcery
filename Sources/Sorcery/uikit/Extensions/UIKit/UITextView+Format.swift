//
//  UITextView_Exensions.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import UIKit

//extension UITextView {
//    /// Changes the views properties based on the provided format and the current theme
//    ///
//    /// - Parameter format: [Assets.Format] enum to be applied
//    /// - Returns: returns self to allow for chaining
//    @discardableResult
//    func format(_ format: Assets.Format) -> UITextView {
//        let theme = ThemeManager.get().theme
//        switch format {
//        case .h1:
//            self.font = App.h1Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h2:
//            self.font = App.h2Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h3:
//            self.font = App.h3Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h4:
//            self.font = App.h4Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h5:
//            self.font = App.h5Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .h6:
//            self.font = App.h6Font
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .title:
//            self.font = App.titleFont
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .subtitle:
//            self.font = App.subtitleFont
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .body:
//            self.font = App.bodyFont
//            self.textAlignment = .left
//            self.textColor = theme.inkColor
//            self.backgroundColor = UIColor.clear
//
//        case .small:
//            self.font = App.smallFont
//            self.textAlignment = .left
//            self.textColor = theme.inkAltColor
//            self.backgroundColor = UIColor.clear
//
//        case .tiny:
//            self.font = App.tinyFont
//            self.textAlignment = .left
//            self.textColor = theme.inkAltColor
//            self.backgroundColor = UIColor.clear
//        }
//        return self
//    }
//}
