//
//  ToolView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class ToolView: UIView {
    // MARK: - Lifecycle

    init(
        _ delegate: ExecuteProtocol? = nil,
        title: String = "",
        icon: String,
        command: Command = NilCommand(),
        backgroundColor: UIColor? =  nil,
        size: CGSize? = nil,
        frame: CGRect? = nil,
        isSelected: Bool = false
    ) {
        _delegate = delegate
        _title = title
        _icon = icon
        _command = command
        _backgroundColor = backgroundColor
        _isSelected = isSelected
        self.size = size ?? CGSize(width: 36, height: 36)

        super.init(frame: frame ?? .zero)
        _setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private var size: CGSize!

    // swiftlint:disable weak_delegate
    private var _delegate: ExecuteProtocol?
    // swiftlint:enable weak_delegate
    private var _title: String
    private var _icon: String
    private var _backgroundColor: UIColor?
    private var _command: Command = NilCommand()

    private var _isSelected: Bool = false
    var isSelected: Bool {
        get {
            return _isSelected
        }
        set(newState) {
            UIView.animate(withDuration: 0.3) {
                self._isSelected = newState
//                self.update()
                self.layoutIfNeeded()
            }
        }
    }

    // MARK: - Views

    let iconImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Methods

    private func _setup() {
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        layer.cornerRadius = 8.0

        // Subviews

        addSubview(iconImageView)

        // Constraints

        iconImageView.constrain(
            centerX: centerXAnchor,
            centerY: centerYAnchor,
            size: .size(width: 24, height: 24)
        )

        // Gestures

        onTap { [weak self] _ in
            guard let self = self else { return }
            _ = self._delegate?.execute?(self._command)
        }

//        update()
    }

    func change(
        icon: String? = nil,
        command: Command? = nil,
        backgroundColor: UIColor? =  nil
    ) {
        _icon = icon ?? _icon
        _command = command ?? _command
        _backgroundColor = backgroundColor ?? _backgroundColor

//        update()
    }

//    override func update() {
//        super.update()
//
//        let theme = ThemeManager.get().theme
//
//        iconImageView.image = UIImage(named: _icon)?.withRenderingMode(.alwaysTemplate)
//        iconImageView.tintColor = theme.appColor
//
//        // Development: colorize views to aid debugging
//        if (theme.isDebug) {
//            backgroundColor = Color.red.withAlphaComponent(0.15)
//        } else {
//            backgroundColor = (_isSelected) ? theme.paperAltColor : Color.clear
//        }
//    }

    override var intrinsicContentSize: CGSize {
        return size
    }
}
