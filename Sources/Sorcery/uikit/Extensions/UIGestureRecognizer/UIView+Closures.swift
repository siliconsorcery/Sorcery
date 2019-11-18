//
// UIView+Closures.swift
// GestureRecognizerClosures
//
// Created by
// Copyright © 2015 Marc Baldwin, MIT License.
// https://github.com/marcbaldwin/GestureRecognizerClosures
//

import UIKit

public extension UIView {
    
    @discardableResult
    func onTap(
        taps: Int = 1,
        touches: Int = 1,
        _ handler: @escaping (UITapGestureRecognizer) -> Void
    ) -> UITapGestureRecognizer {
        self.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(
            taps: taps,
            touches: touches,
            handler: handler
        )
        addGestureRecognizer(recognizer)
        return recognizer
    }

    func onDoubleTap(_ handler: @escaping (UITapGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(taps: 2, handler: handler))
    }

    func onTriple(_ handler: @escaping (UITapGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(taps: 3, handler: handler))
    }

    func onDoubleTaps(
        tapHandler: @escaping (UITapGestureRecognizer) -> Void,
        doubleTapHandler: @escaping (UITapGestureRecognizer) -> Void
    ) {
        Log.warn("On advisable due to fail to single tap delay")

        self.isUserInteractionEnabled = true

        let double = UITapGestureRecognizer(taps: 2, handler: doubleTapHandler)

        let single = UITapGestureRecognizer(taps: 1, handler: tapHandler)
        single.require(toFail: double)

        addGestureRecognizer(double)
        addGestureRecognizer(single)
    }

    func onTripleTaps(
        tapHandler: @escaping (UITapGestureRecognizer) -> Void,
        doubleTapHandler: @escaping (UITapGestureRecognizer) -> Void,
        tripleTapHandler: @escaping (UITapGestureRecognizer) -> Void
    ) {
        Log.warn("On advisable due to fail to single/double tap delays")

        self.isUserInteractionEnabled = true

        let triple = UITapGestureRecognizer(taps: 3, handler: tripleTapHandler)

        let double = UITapGestureRecognizer(taps: 2, handler: doubleTapHandler)
        double.require(toFail: triple)

        let single = UITapGestureRecognizer(taps: 1, handler: tapHandler)
        single.require(toFail: double)

        addGestureRecognizer(triple)
        addGestureRecognizer(double)
        addGestureRecognizer(single)
    }

    func onTaps(
        tapHandler: @escaping (UITapGestureRecognizer) -> Void,
        doubleTapHandler: @escaping (UITapGestureRecognizer) -> Void,
        tripleTapHandler: @escaping (UITapGestureRecognizer) -> Void
    ) {
        Log.warn("On advisable due to fail to tap delays")

        self.isUserInteractionEnabled = true

        let triple = UITapGestureRecognizer(taps: 3, handler: tripleTapHandler)

        let double = UITapGestureRecognizer(taps: 2, handler: doubleTapHandler)
        double.require(toFail: triple)

        let single = UITapGestureRecognizer(taps: 1, handler: tapHandler)
        single.require(toFail: double)

        addGestureRecognizer(triple)
        addGestureRecognizer(double)
        addGestureRecognizer(single)
    }

    @discardableResult
    func onLongPress(_ handler: @escaping (UILongPressGestureRecognizer) -> Void) -> UILongPressGestureRecognizer {
        self.isUserInteractionEnabled = true
		let recognizer = UILongPressGestureRecognizer(handler: handler)
        addGestureRecognizer(recognizer)
		return recognizer
    }

    @discardableResult
    func onSwipe(
        direction: UISwipeGestureRecognizer.Direction = .right,
        touches: Int = 1,
        _ handler: @escaping (UISwipeGestureRecognizer) -> Void
    ) -> UISwipeGestureRecognizer {
        self.isUserInteractionEnabled = true
        let recognizer = UISwipeGestureRecognizer(
            direction: direction,
            handler: handler
        )
        recognizer.numberOfTouchesRequired = touches
        addGestureRecognizer(recognizer)
        return recognizer
    }

    func onSwipeLeft(_ handler: @escaping (UISwipeGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UISwipeGestureRecognizer(direction: .left, handler: handler))
    }

    func onSwipeRight(_ handler: @escaping (UISwipeGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UISwipeGestureRecognizer(direction: .right, handler: handler))
    }

    func onSwipeUp(_ handler: @escaping (UISwipeGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UISwipeGestureRecognizer(direction: .up, handler: handler))
    }

    func onSwipeDown(_ handler: @escaping (UISwipeGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UISwipeGestureRecognizer(direction: .down, handler: handler))
    }

    @discardableResult
    func onPan(
        isSimultaneous: Bool = true,
        _ handler: @escaping (UIPanGestureRecognizer) -> Void
    ) -> UIPanGestureRecognizer {
        self.isUserInteractionEnabled = true
        let recognizer = UIPanGestureRecognizer(handler: handler)
//        if isSimultaneous {
//            recognizer.delegate = Services.simultaneousGestures
//        }
        addGestureRecognizer(recognizer)
        return recognizer
    }

    @discardableResult
    func onPinch(
        isSimultaneous: Bool = true,
        _ handler: @escaping (UIPinchGestureRecognizer) -> Void
    ) -> UIPinchGestureRecognizer {
        self.isUserInteractionEnabled = true
        let recognizer = UIPinchGestureRecognizer(handler: handler)
//        if isSimultaneous {
//            recognizer.delegate = Services.simultaneousGestures
//        }
        addGestureRecognizer(recognizer)
        return recognizer
    }

    @discardableResult
    func onRotate(
        isSimultaneous: Bool = true,
        _ handler: @escaping (UIRotationGestureRecognizer) -> Void
    ) -> UIRotationGestureRecognizer {
        self.isUserInteractionEnabled = true
        let recognizer = UIRotationGestureRecognizer(handler: handler)
//        if isSimultaneous {
//            recognizer.delegate = Services.simultaneousGestures
//        }
        addGestureRecognizer(recognizer)
        return recognizer
    }

    func onScreenEdgePan(_ handler: @escaping (UIScreenEdgePanGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIScreenEdgePanGestureRecognizer(handler: handler))
    }
}
