//
//  UILayoutGuide+Anchor.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

extension UILayoutGuide {
    /// The constrain extension will apply the fully qualified constriants to the UILayoutGuide.
    /// Need to supply any combination of parameters that results in
    /// position and size of the UILayoutGuide to be constrained
    ///
    /// - Parameters:
    ///   - activate: Bool if true activate all defined constraints
    ///   - top: self.topAnchor relative to top
    ///   - left: self.leftAnchor relative to left
    ///   - bottom: self.bottomAnchor relative to bottom
    ///   - right: self.rightAnchor relative to right
    ///   - centerX: self.centerXAnchor relative to centerX
    ///   - centerY: self.centerYAnchor relative to centerY
    ///   - width: self.widthAnchor relative to width
    ///   - height: self.heightAnchor relative to height
    ///   - size: self.widthAnchor & self.heightAnchor equal to constants
    ///   - widthConstraint: Predefined
    ///   - heightConstraint: Predefined
    ///   - ratio: Multipler ratio for width and height
    ///   - margin: self.layoutMargins
    ///   - padding: padding changes size and position
    ///   - offset: offset changes position
    ///
    /// - Returns: array of NSLayoutConstraint
    ///
    /// - Examples:
    ///    top, left, bottom, right
    ///    top, left, width, height
    ///    top, left, size(width: 100, height: 50)
    ///    centerX, top, width, height
    ///
    @discardableResult
    func constrain(
        activate: Bool = true,

        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,

        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,

        width: NSLayoutDimension? = nil,
        height: NSLayoutDimension? = nil,
        size: CGSize = .zero,
        widthConstraint: NSLayoutConstraint? = nil,
        heightConstraint: NSLayoutConstraint? = nil,
        ratio: CGSize = .size(width: 1.0, height: 1.0),

        padding: UIEdgeInsets = .zero,
        offset: UIEdgeInsets = .zero
        ) -> [NSLayoutConstraint] {
        var constraintList: [NSLayoutConstraint] = []

        let hasPinnedWidth = (left != nil && right != nil)
        let hasPinnedHeight = (top != nil && bottom != nil)

        if let top = top {
            constraintList.append(
                topAnchor.constraint(equalTo: top, constant: padding.top + offset.top)
            )
        }
        if let left = left {
            constraintList.append(
                leftAnchor.constraint(equalTo: left, constant: padding.left + offset.left)
            )
        }
        if let centerX = centerX {
            constraintList.append(
                centerXAnchor.constraint(equalTo: centerX, constant: (padding.left - padding.right) / 2 + (offset.left + offset.right) / 2 )
            )
        }
        if let bottom = bottom {
            constraintList.append(
                bottomAnchor.constraint(equalTo: bottom, constant: -(padding.bottom + offset.bottom))
            )
        }
        if let right = right {
            constraintList.append(
                rightAnchor.constraint(equalTo: right, constant: -(padding.right + offset.right))
            )
        }
        if let centerY = centerY {
            constraintList.append(
                centerYAnchor.constraint(
                    equalTo: centerY,
                    constant: (padding.top - padding.bottom) / 2 + (offset.top + offset.bottom) / 2
                )
            )
        }
        if let width = width {
            constraintList.append(
                widthAnchor.constraint(
                    equalTo: width,
                    multiplier: ratio.width,
                    constant: -(padding.left + padding.right)
                )
            )
        }
        if let height = height {
            assert(!hasPinnedHeight, "Already have a height")
            constraintList.append(
                heightAnchor.constraint(
                    equalTo: height,
                    multiplier: ratio.height,
                    constant: -(padding.top + padding.bottom)
                )
            )
        }
        if size.width != 0 {
            assert(!hasPinnedWidth && width == nil, "Already have a width")
            constraintList.append(
                widthAnchor.constraint(equalToConstant: size.width * ratio.width)
            )
        }
        if size.height != 0 {
            assert(!hasPinnedHeight && height == nil, "Already have a height")
            constraintList.append(
                heightAnchor.constraint(equalToConstant: size.height * ratio.height)
            )
        }

        if activate {
            if let widthConstraint = widthConstraint {
                NSLayoutConstraint.activate([widthConstraint])
            }
            if let heightConstraint = heightConstraint {
                NSLayoutConstraint.activate([heightConstraint])
            }
            NSLayoutConstraint.activate(constraintList)
        }
        return constraintList
    }
}
