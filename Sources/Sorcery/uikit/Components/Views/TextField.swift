//
//  TextField.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

class TextField: UITextField {
    init(
        frame: CGRect? = nil,
        placeholder: String? = nil
    ) {
        super.init(frame: frame ?? .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        borderStyle = .none
        layer.cornerRadius = 4
//        font = App.subtitleFont
        adjustsFontSizeToFitWidth = false

//        update()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return _inset(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return _inset(forBounds: bounds)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return _inset(forBounds: bounds)
    }

    private func _inset(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .insets(vertical: 8, horizontal: 16))
    }
}
