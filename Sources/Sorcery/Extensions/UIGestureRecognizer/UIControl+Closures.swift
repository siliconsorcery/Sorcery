//
// UIControl+Closures.swift
// GestureRecognizerClosures
//
// Created by
// Copyright © 2015 Marc Baldwin, MIT License.
// https://github.com/marcbaldwin/GestureRecognizerClosures
//

import UIKit

extension UIControl {
    /// Adds a handler that will be invoked for the specified control events
    func on(_ controlEvents: UIControl.Event, invokeHandler handler: @escaping (UIControl) -> Void) -> AnyObject {
        let closureHandler = ClosureHandler(handler: handler, control: self)
        addTarget(closureHandler, action: kClosureHandlerSelector, for: controlEvents)
        var handlers = self.handlers ?? Set<ClosureHandler<UIControl>>()
        handlers.insert(closureHandler)
        self.handlers = handlers
        return closureHandler
    }

    /// Removes a handler from the control
    func removeHandler(_ handler: AnyObject) {
        guard let handler = handler as? ClosureHandler<UIControl> else { return }
        removeTarget(handler, action: kClosureHandlerSelector, for: .allEvents)
        if var handlers = self.handlers {
            handlers.remove(handler)
            self.handlers = handlers
        }
    }
}

private var HandlerKey: UInt8 = 0

extension UIControl {
    var handlers: Set<ClosureHandler<UIControl>>? {
        get { return objc_getAssociatedObject(self, &HandlerKey) as? Set<ClosureHandler<UIControl>> }
        set { objc_setAssociatedObject(self, &HandlerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
