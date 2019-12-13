//
//  UIView+Global.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

extension UIView {
    public var globalPoint: CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    public var globalFrame: CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
}
