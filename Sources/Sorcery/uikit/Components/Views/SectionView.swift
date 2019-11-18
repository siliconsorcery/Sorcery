//
//  SectionView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class SectionView: UIView {
    // MARK: - Lifecycle

    init(
        _ title: String = "",
        frame: CGRect? = nil,
        height: CGFloat? = 44.0,
        backgroundColor: UIColor? =  nil,
        hasShadow: Bool = false
    ) {
        _height = height
        _backgroundColor = backgroundColor
        _title = title
        _hasShadow = hasShadow
        super.init(frame: frame ?? .zero)
        _setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private var _height: CGFloat?
    private var _backgroundColor: UIColor?
    private var _title: String
    private var _hasShadow: Bool

    // MARK: - Views

    let titleButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentVerticalAlignment = .bottom
        view.contentHorizontalAlignment = .left
        view.isUserInteractionEnabled = false
        return view
    }()

    // MARK: - Methods

    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false

        // Add subviews

        addSubview(titleButton)

        // Add constraints

        titleButton.constrain(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            padding: .insets(left: 16)
        )

//        update()
    }

//    override func update() {
//        super.update()
//        let theme = ThemeManager.get().theme
//
//        titleButton.setTitle(_title, for: .normal)
//        titleButton.setTitleColor(theme.inkAlt2Color, for: .normal)
//        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold) // BOGUS:
//
//        var paperColor: UIColor!
//        if let color = _backgroundColor {
//            paperColor = (theme.isDark) ? color.reverseLightness() : color
//        } else {
//            paperColor = theme.paperColor
//        }
//        backgroundColor = paperColor
//
//        if _hasShadow {
//            layer.shadowColor = Color.black.cgColor
//            layer.shadowOpacity = 0.4
//            layer.shadowOffset = .zero
//            layer.shadowRadius = 4.0
//        }
//    }

    override var intrinsicContentSize: CGSize {
        if let height = _height {
            return CGSize(width: 0.0, height: height)
        } else {
            return frame.size
        }
    }
}
