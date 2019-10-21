//
// GestureClosure.swift
// GestureRecognizerClosures
//
// Created by
// Copyright © 2015 Marc Baldwin, MIT License.
// https://github.com/marcbaldwin/GestureRecognizerClosures
//

import UIKit

private var HandlerKey: UInt8 = 0

extension UIGestureRecognizer {
    func setHandler<T: UIGestureRecognizer>(_ instance: T, handler: ClosureHandler<T>) {
        objc_setAssociatedObject(self, &HandlerKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        handler.control = instance
    }

    func handler<T>() -> ClosureHandler<T> {
        return objc_getAssociatedObject(self, &HandlerKey) as! ClosureHandler
    }
}
