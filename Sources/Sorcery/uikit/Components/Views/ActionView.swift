//
//  ActionView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
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
    }

    override var intrinsicContentSize: CGSize {
        if let height = _height {
            return CGSize(width: 0.0, height: height)
        } else {
            return frame.size
        }
    }
}
