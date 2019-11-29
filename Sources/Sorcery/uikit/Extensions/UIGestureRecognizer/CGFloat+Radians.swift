//
//  CGFloat+Radians.swift
//  firelist
//
//  Created by John Cumming on 1/16/19.
//  Copyright © 2019 Booth Hill Software, Inc. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    public var radians: CGFloat {
        return CGFloat.pi * (self / 180)
    }

    public init(degrees: CGFloat) {
        self = CGFloat.pi * degrees / 180
    }
}
