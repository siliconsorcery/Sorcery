//
//  UIStackView+Background.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import Foundation
import UIKit

extension UIStackView {
    public func changeBackgroundColor(_ color: UIColor) {
        let backgroundLayer = CAShapeLayer()
        layer.insertSublayer(backgroundLayer, at: 0)
        backgroundLayer.path = UIBezierPath(rect: bounds).cgPath
        backgroundLayer.fillColor = color.cgColor
    }
}
