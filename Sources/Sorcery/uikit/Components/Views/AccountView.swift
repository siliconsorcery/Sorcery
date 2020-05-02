//
//  AccountView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

class AccountView: UIView {
    // MARK: - Lifecycle

    init(
        _ delegate: ExecuteProtocol? = nil,
        name: String = "",
        initials: String = "",
        email: String = "",
        frame: CGRect? = nil,
        height: CGFloat? = 40.0,
        backgroundColor: UIColor? =  nil,
        hasShadow: Bool = false
    ) {
        _delegate = delegate
        _name = name
        _initials = initials
        _email = email
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
    private var _name: String
    private var _initials: String
    private var _email: String
    private var _height: CGFloat?
    private var _backgroundColor: UIColor?
    private var _hasShadow: Bool

    // MARK: - Views

    let piconView: UIView = {
        let view = UIView()
        view.backgroundColor = Material.white
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 20.0
        return view
    }()

    let initialsView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.format(.title)
        return view
    }()

    let nameView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.format(.title)
        return view
    }()

    let emailView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.format(.subtitle)
        return view
    }()

    let rightsView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.format(.tiny).align(.right)
        return view
    }()

    // MARK: - Methods

    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false

        // Add subviews

        addSubview(piconView)
        addSubview(initialsView)
        addSubview(nameView)
        addSubview(emailView)
        addSubview(rightsView)

        // Add constraints

        piconView.constrain(
            left: leftAnchor,
            bottom: bottomAnchor,
            size: .size(width: 40.0, height: 40.0),
            padding: .insets(left: 12.0, bottom: 16.0)
        )

        initialsView.constrain(
            centerX: piconView.centerXAnchor,
            centerY: piconView.centerYAnchor
        )

        nameView.constrain(
            top: piconView.topAnchor,
            left: piconView.rightAnchor,
//            bottom: emailView.topAnchor,
            right: rightAnchor,
            padding: .insets(left: 12.0)
        )

        emailView.constrain(
//            top: nameView.bottomAnchor,
            left: nameView.leftAnchor,
            bottom: piconView.bottomAnchor,
            right: nameView.rightAnchor
        )
        
        rightsView.constrain(
            top: piconView.topAnchor,
            left: piconView.rightAnchor,
            bottom: piconView.bottomAnchor,
            right: nameView.rightAnchor,
            padding: .insets(right: 12.0)
        )

        // Gestures
        piconView.onTap { [weak self] _ in
            guard let this = self else { return }
            _ = this._delegate?.execute?(NilOrder())
        }

//        update()
    }

//    override func update() {
//        let theme = ThemeManager.get().theme
//
//        initialsView.text = _initials
//        initialsView.textColor = theme.appColor
//
//        nameView.text = _name
//        nameView.textColor = theme.paperColor
//
//        emailView.text = _email
//        emailView.textColor = theme.paperColor
//
//        rightsView.text = ""
//        rightsView.textColor = theme.paperColor
//
//        piconView.tintColor = theme.paperColor
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
