//
//  UIStackView+Background.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func changeBackgroundColor(_ color: UIColor) {
        let backgroundLayer = CAShapeLayer()
        layer.insertSublayer(backgroundLayer, at: 0)
        backgroundLayer.path = UIBezierPath(rect: bounds).cgPath
        backgroundLayer.fillColor = color.cgColor
    }
}
