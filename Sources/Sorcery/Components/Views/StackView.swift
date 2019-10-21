//
//  StackView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class StackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        tintColor = Color.blue.shift(lightness: -0.25)

        axis = .vertical
        alignment = .fill
        distribution = .fillProportionally
        spacing = 0.0
        isBaselineRelativeArrangement = false

        contentMode = .scaleToFill

        clearsContextBeforeDrawing = true
        clipsToBounds = true
        autoresizesSubviews = true
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func tools(
        arrangedSubviews: [UIView],
        isLoose: Bool = false
    ) -> StackView {
        let view = StackView(arrangedSubviews: arrangedSubviews)
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = isLoose ? 12.0 : 4.0
        view.isBaselineRelativeArrangement = true
        return view
    }

    static func menu(arrangedSubviews: [UIView]) -> StackView {
        let view = StackView(arrangedSubviews: arrangedSubviews)
        return view
    }
}
