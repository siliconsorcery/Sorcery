//
//  UIView+Theme.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import UIKit

//extension UIViewController {
//    @objc
//    func update() {
//    }
//}
//
//extension UIView {
//    /// Subclasses can override to update their theme information
//    @objc
//    func update() {
//    }
//
//    /// Walks the view hierarchy and calls update()
//    func updateSubviews() {
//        for childView in subviews {
//            childView.updateSubviews()
//        }
//        update()
//    }
//
//    /// Finds the UIViewController that's responsible for the view
//    ///
//    /// - Returns: instance of UIViewController or nil
//    func findViewController() -> UIViewController? {
//        if let nextResponder = self.next as? UIViewController {
//            return nextResponder
//        } else if let nextResponder = self.next as? UIView {
//            return nextResponder.findViewController()
//        } else {
//            return nil
//        }
//    }
//
//    /// Return all the viewControllers that contribute to the view hierarchy
//    ///
//    /// - Parameter viewControllerList: used for collecting the unique viewControllers
//    /// - Returns: Array of unique viewControllers or empty array
//    func findAllViewControllers(_ viewControllerList: [UIViewController] = []) -> [UIViewController] {
//        var viewControllerList = viewControllerList
//
//        for childView in subviews {
//            viewControllerList = childView.findAllViewControllers(viewControllerList)
//        }
//        if let viewController = findViewController() {
//            // Found a viewController, add it to the list if it's new
//            if (viewControllerList.contains(viewController) == false) {
//                viewControllerList.append(viewController)
//            }
//        }
//        return viewControllerList
//    }
//}
//
//extension UILabel {
//    @objc
//    override func update() {
//        let style = ThemeManager.get().theme
//        textColor = style.inkColor
//    }
//}
//
//extension UITabBar {
//    @objc
//    override func update() {
//        let style = ThemeManager.get().theme
//        barStyle = (style.isDark) ? UIBarStyle.black : UIBarStyle.default
//        backgroundColor = style.paperColor
//        tintColor = style.appColor
//    }
//}
//
//extension UITableView {
//    @objc
//    override func update() {
//        let theme = ThemeManager.get().theme
//        backgroundColor = theme.paperColor
//    }
//}
//
//extension UINavigationBar {
//    @objc
//    override func update() {
//        let theme = ThemeManager.get().theme
//        prefersLargeTitles = false
//        //            isTranslucent = true
//        //            barStyle = UIBarStyle.blackTranslucent
//        titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: theme.inkColor
//        ]
//        largeTitleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: theme.inkColor
//        ]
//        barTintColor = theme.paperColor
//        tintColor = theme.appColor
//        backgroundColor = theme.paperColor
//    }
//}
//
//class UIViewBackground: UIView {
//    override func update() {
//        let theme = ThemeManager.get().theme
//        backgroundColor = theme.paperColor
//    }
//}
