//
//  FlexView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class FlexView: UIView {
    // MARK: - Lifecycle

    init(
        _ axis: NSLayoutConstraint.Axis = .horizontal,
        frame: CGRect? = nil
    ) {
        super.init(frame: frame ?? .zero)
        _axis = axis
        _setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    var _axis: NSLayoutConstraint.Axis!

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
//        backgroundColor = Color.purple
//        setContentHuggingPriority(.defaultLow, for: _axis)
//    }

//    override var intrinsicContentSize: CGSize {
//        let size = super.intrinsicContentSize
//        return CGSize(width: size.width + 16, height: size.height)
//    }

}
