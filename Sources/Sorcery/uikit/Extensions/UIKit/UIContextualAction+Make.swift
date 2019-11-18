//
//  UIContextualAction+Make.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

extension UIContextualAction {
    static func make(
        style: UIContextualAction.Style = .normal,
        title: String,
        image: UIImage,
        backgroundColor: UIColor,
        handler: @escaping UIContextualAction.Handler
        ) -> UIContextualAction {
        let contextualAction = UIContextualAction(style: style, title: title, handler: handler)
        contextualAction.image = image
        contextualAction.backgroundColor = backgroundColor
        return contextualAction
    }
}
