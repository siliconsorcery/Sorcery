//
//  UIView+Gestures.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation

import UIKit

extension UIView {
    public func addGestures(target: Any?, action: Selector?) {
        let tripleTapGesture = UITapGestureRecognizer(target: target, action: action)
        tripleTapGesture.numberOfTapsRequired = 3

        let doubleTapGesture = UITapGestureRecognizer(target: target, action: action)
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.require(toFail: tripleTapGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: target, action: action)

        addGestureRecognizer(tripleTapGesture)
        addGestureRecognizer(doubleTapGesture)
        addGestureRecognizer(longPressGesture)
    }
}
