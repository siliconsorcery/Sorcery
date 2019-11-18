//
// GestureClosure.swift
// GestureRecognizerClosures
//
// Created by
// Copyright © 2015 Marc Baldwin, MIT License.
// https://github.com/marcbaldwin/GestureRecognizerClosures
//

import Foundation

internal let kClosureHandlerSelector = Selector(("handle"))

internal class ClosureHandler<T: AnyObject>: NSObject {
    internal var handler: ((T) -> Void)?
    internal weak var control: T?

    internal init(handler: @escaping (T) -> Void, control: T? = nil) {
        self.handler = handler
        self.control = control
    }

    @objc
    func handle() {
        if let control = self.control {
            handler?(control)
        }
    }
}
