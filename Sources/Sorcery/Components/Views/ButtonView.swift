//
//  ButtonView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
    // MARK: - Lifecycle

    init(
        _ title: String = "",
        titleColor: UIColor = Color.white,
//        titleFormat: Assets.Format = .body,
        backgroundColor: UIColor = Color.blue.shift(lightness: -0.6)
    ) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
//        titleLabel?.format(titleFormat)
        layer.cornerRadius = 8.0
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
