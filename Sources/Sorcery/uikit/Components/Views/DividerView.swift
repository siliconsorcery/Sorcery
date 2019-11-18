//
//  DividerView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class DividerView: UIView {
    // MARK: - Lifecycle

    init(
        backgroundColor: UIColor? =  nil,
        frame: CGRect? = nil
    ) {
        _backgroundColor = backgroundColor
        super.init(frame: frame ?? .zero)
        _setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private var _backgroundColor: UIColor?

    // MARK: - Views

    let dividerView: UIView = {
        let view = UIView()
        return view
    }()

    // MARK: - Methods

    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(.defaultHigh, for: .horizontal)

        // Subviews

        addSubview(dividerView)

        // Constraints

        dividerView.constrain(
            centerX: centerXAnchor,
            centerY: centerYAnchor,
            size: .size(width: 1, height: 20)
        )

//        update()
    }

//    override func update() {
//        super.update()
//
//        let theme = ThemeManager.get().theme
//
//        dividerView.backgroundColor = theme.inkAlt2Color
//
//        backgroundColor = Color.clear
//
//        // Development: colorize views to aid debugging
//        if (theme.isDebug) {
//            backgroundColor = Color.red.withAlphaComponent(0.15)
//        } else {
//            backgroundColor = Color.clear
//        }
//    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 1.0, height: 16.0)
    }
}
