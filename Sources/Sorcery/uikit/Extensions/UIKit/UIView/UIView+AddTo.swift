//
//  UIView_Extensions.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addTo(_ view: UIView) {
        view.addSubview(self)
        frame = view.bounds
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
