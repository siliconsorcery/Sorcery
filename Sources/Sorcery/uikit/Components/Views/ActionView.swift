//
//  ActionView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class ActionView: UIView {
    // MARK: - Lifecycle

    init(
        _ delegate: ExecuteProtocol? = nil,
        title: String = "",
        icon: String,
        command: Command = NilCommand(),
        frame: CGRect? = nil,
        height: CGFloat? = 40.0,
        backgroundColor: UIColor? =  nil,
        hasShadow: Bool = false,
        isSelected: Bool = false
    ) {
        _delegate = delegate
        _title = title
        _icon = icon
        _command = command
        _height = height
        _backgroundColor = backgroundColor
        _hasShadow = hasShadow
        _isSelected = isSelected
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
    private var _icon: String
    private var _height: CGFloat?
    private var _backgroundColor: UIColor?
    private var _hasShadow: Bool
    private var _command: Command = NilCommand()
    private var _isSelected: Bool = false

    // MARK: - Views

    let iconImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    // MARK: - Methods

    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false

        // Add subviews

        addSubview(iconImageView)
        addSubview(titleLabel)

        // Add constraints

        iconImageView.constrain(
            left: leftAnchor,
            centerY: centerYAnchor,
            size: .size(width: 24, height: 24),
            padding: .insets(left: 16, right: 8)
        )

        titleLabel.constrain(
            left: iconImageView.rightAnchor,
            right: rightAnchor,
            centerY: centerYAnchor,
            padding: .insets(left: 8, right: 16)
        )

        // Gestures

//        onTap { [weak self] _ in
//            guard let this = self else { return }
//            if let execute = this._delegate?.execute {
//                if let navigateCommand = this._command as? NavigateCommand {
//                    Log.info("Mode: \(navigateCommand.route)")
//                }
//                _ = execute(this._command)
//            } else {
//                Log.warn("No handler for ActionView")
//            }
//        }

//        update()
    }

//    override func update() {
//        super.update()
//        let theme = ThemeManager.get().theme
//
//        titleLabel.text = _title
//        titleLabel.textColor = theme.inkColor
//
//        iconImageView.image = UIImage(named: _icon)?.withRenderingMode(.alwaysTemplate)
//        iconImageView.tintColor = theme.appColor
//
//        var paperColor: UIColor!
//        if let color = _backgroundColor {
//            paperColor = (theme.isDark) ? color.reverseLightness() : color
//        } else {
//            paperColor = theme.paperColor
//        }
//        backgroundColor = (_isSelected) ? theme.paperAltColor : paperColor
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
