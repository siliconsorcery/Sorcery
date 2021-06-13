//
//  Component.swift
//  ComponentProject
//
//  Created by John Cumming on 11/16/17.
//  Copyright © 2017 Silicon Sorcery. All rights reserved.
//
// Extends UIView,with:
// - Optional onCommand delegate callback
// - Choke point for all command execution, useful for logging
// - Methods for loading view from Storyboard or NIB files. BOGUS: Needs testing
import UIKit

class Component: UIView {
    // MARK: - LifeCycle

    // MARK: - Properties

    var onCommand: ((Order) -> (Response?))?

    // Refactor onChange to onCommand(), for now allow both and Log.warning()
    var onChange: ((String) -> (Bool))?

    // Views

    // BOGUS: View within a view!
    private var _view = UIView()
    var view: UIView {
        get {
            return _view
        }
        set(value) {
            view.removeFromSuperview()
            _view = value
            addSubview(_view)
        }
    }

    // MARK: - Methods

    /// Choke point! Runs commands and returns response
    ///
    /// - Parameter command: command to run
    /// - Returns: response
    @discardableResult
    func on(_ command: Order) -> Response? {
        return onCommand?(command)
    }

    func setup(_ nibName: String? = nil) {
        if let nibName = nibName {
            let newView = loadView(from: nibName)
            newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            newView.frame = bounds
            self.view = newView
        }
    }

    func loadView(from nibName: String, framedTo bounds: CGRect? = nil) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        if let bounds = bounds {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        return view
    }

    // MARK: Abstract Methods

    func calculatedHeight() -> CGFloat {
        return frame.size.height
    }

    func show() {
        Log.warning("Implement in derived class")
    }

    func willDismiss() {
        Log.warning("Implement in derived class")
    }

    // MARK: - Overrides

}
