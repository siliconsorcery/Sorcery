//
//  SpaceView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class SpaceView: UIView {
    // MARK: - Lifecycle

    init(
        _ axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 4.0,
        frame: CGRect? = nil
    ) {
        super.init(frame: frame ?? .zero)
        _axis = axis
        _spacing = spacing
        _setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    var _axis: NSLayoutConstraint.Axis!
    var _spacing: CGFloat!

    // MARK: - Views

    // MARK: - Methods

    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false

        // Subviews

        // Constraints

//        update()
    }

//    override func update() {
//        super.update()
//        setContentHuggingPriority(.defaultHigh, for: _axis)
//    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        if _axis == .horizontal {
            size.width = _spacing
        } else {
            size.height = _spacing
        }
        return size
    }
}
