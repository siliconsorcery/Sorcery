//
//  UIContextualAction+Make.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

extension UIContextualAction {
    public static func make(
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
