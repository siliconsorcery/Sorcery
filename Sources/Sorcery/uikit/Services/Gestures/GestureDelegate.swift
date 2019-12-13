//
//  GestureDelegate.swift
//  pilot
//
//  Created by John Cumming on 2/4/19.
//  Copyright © 2019 John Cumming. All rights reserved.
//

import UIKit

public class SimultaneousGestureDelegate: NSObject, UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
}
