//
//  LabelView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class LabelView: UILabel {
    // MARK: - Lifecycle

    init(
        _ title: String = "",
        frame: CGRect? = nil
    ) {
        _title = title
        super.init(frame: frame ?? .zero)
        _setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private var _title: String

    private let _duration = 0.3

    // MARK: - Views

    // MARK: - Methods

    private func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
//        format(.title)

        // Subviews

        // Constraints

//        update()
    }

//    override func update() {
//        super.update()
//
//        let theme = ThemeManager.get().theme
//
//        text = _title
//        textColor = theme.inkColor
//        backgroundColor = Color.clear
//
//        setContentHuggingPriority(.defaultHigh, for: .horizontal)
//    }

    func hide() {
        UIView.animate(withDuration: self._duration) {
            self.isHidden = true
        }
    }

    func show() {
        UIView.animate(withDuration: self._duration) {
            self.isHidden = false
        }
    }

    func title(_ title: String) {
        UIView.animate(
            withDuration: self._duration * 0.5,
            animations: {
                self.isHidden = true
            },
            completion: { _ in
                self._title = title
                self.text = title
                UIView.animate(
                    withDuration: self._duration * 0.5
                ) {
                    self.isHidden = false
                }
            }
        )
    }
}
