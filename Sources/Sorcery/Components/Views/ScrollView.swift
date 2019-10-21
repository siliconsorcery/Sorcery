//
//  ScrollView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

class ScrollView: UIScrollView {
    init(
        frame: CGRect? = nil,
        inset: UIEdgeInsets = UIEdgeInsets(),
        backgroundColor: UIColor? = nil
    ) {
        super.init(frame: frame ?? .zero)
        _backgroundColor = backgroundColor

        translatesAutoresizingMaskIntoConstraints = false
        contentInset = inset
        clipsToBounds = true

//        update()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var _backgroundColor: UIColor?

//    override func update() {
//        super.update()
//        let theme = ThemeManager.get().theme
//
//        var paperColor: UIColor!
//        if let color = _backgroundColor {
//            paperColor = (theme.isDark) ? color.reverseLightness() : color
//        } else {
//            paperColor = theme.paperColor
//        }
//
//        backgroundColor = paperColor
//    }
}
