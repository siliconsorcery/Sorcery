//
//  BlockView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

class SeparatorView: UIView {
    init(
        frame: CGRect? = nil,
        height: CGFloat? = 1.0,
        backgroundColor: UIColor? = nil,
        hasShadow: Bool = false
    ) {
        _height = height
        _backgroundColor = backgroundColor
        _hasShadow = hasShadow
        super.init(frame: frame ?? .zero)

        translatesAutoresizingMaskIntoConstraints = false

//        update()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var _height: CGFloat?
    private var _backgroundColor: UIColor?
    private var _hasShadow: Bool

    override var intrinsicContentSize: CGSize {
        if let height = _height {
            return CGSize(width: 0.0, height: height)
        } else {
            return frame.size
        }
    }
}
