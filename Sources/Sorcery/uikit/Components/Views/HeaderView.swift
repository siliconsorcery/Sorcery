//
//  HeaderView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

class HeaderView: UIView {
    // MARK: - Lifecycle

    init(
        _ delegate: ExecuteProtocol? = nil,
        title: String = "",
        frame: CGRect? = nil,
        height: CGFloat? = 40.0,
        backgroundColor: UIColor? =  nil,
        hasShadow: Bool = false
    ) {
        _delegate = delegate
        _title = title
        _height = height
        _backgroundColor = backgroundColor
        _hasShadow = hasShadow
        super.init(frame: frame ?? .zero)
        _setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    // swiftlint:disable weak_delegate
    private var _delegate: ExecuteProtocol?
    // swiftlint:enable weak_delegate
    private var _title: String
    private var _height: CGFloat?
    private var _backgroundColor: UIColor?
    private var _hasShadow: Bool

    // MARK: - Views

    let iconImageView: CustomImageView = {
        let view = CustomImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "exit")?.withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        return view
    }()

    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.format(.h3)
        return view
    }()

    // MARK: - Methods

    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false

        // Add subviews

        addSubview(titleLabel)
        addSubview(iconImageView)

        // Add constraints

        titleLabel.constrain(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: iconImageView.rightAnchor,
            padding: .insets(left: 16, bottom: 8, right: 8)
        )

        iconImageView.constrain(
            left: titleLabel.rightAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            padding: .insets(bottom: 8, right: 16)
        )

        // Gestures

        iconImageView.onTap { [weak self] _ in
            guard let this = self else { return }
            _ = this._delegate?.execute?(NilOrder())
        }

//        update()
    }

//    override func update() {
//        let theme = ThemeManager.get().theme
//
//        titleLabel.text = _title
//        titleLabel.textColor = theme.paperColor
//
//        iconImageView.tintColor = theme.paperColor
//
//        var paperColor: UIColor!
//        if let color = _backgroundColor {
//            paperColor = (theme.isDark) ? color.reverseLightness() : color
//        } else {
//            paperColor = theme.appColor
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
