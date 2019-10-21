//
//  UIView+Constrain.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

enum Alignment: Int {
    case topLeft = 0
    case topCenter = 1
    case topRight = 2
    case middleLeft = 3
    case middleCenter = 4
    case middleRight = 5
    case bottomLeft = 6
    case bottomCenter = 7
    case bottomRight = 8
    case edges = 9
}

extension CGSize {
    /// Create a CGSize with silent defaults
    ///
    /// - Parameters:
    ///   - width: width
    ///   - height: height
    /// - Returns: New CGSize
    /// Eg. CGSize.size(height: 42) > CGSize(width: 0, height: 42)
    static func size(
        width: CGFloat = 0.0,
        height: CGFloat = 0.0
    ) -> CGSize {
        return CGSize(width: width, height: height)
    }
}

extension UIEdgeInsets {
    /// Create a UIEdgeInsets with silent defaults
    ///
    /// - Parameters:
    ///   - top: top
    ///   - left: left
    ///   - bottom: bottom
    ///   - right: right
    /// - Returns: new UIEdgeInsets
    ///
    /// Eg. UIEdgeInsets.padding(top: 8, right: 16) > UIEdgeInsets(top 8, left: 0, bottom: 0, right: 16)
    /// Eg. UIEdgeInsets.padding(horizontal: 16) > UIEdgeInsets(top 0, left: 16, bottom: 0, right: 16)
    ///
    static func insets(
        top: CGFloat = 0.0,
        left: CGFloat = 0.0,
        bottom: CGFloat = 0.0,
        right: CGFloat = 0.0,
        vertical: CGFloat = 0.0,
        horizontal: CGFloat = 0.0
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: (vertical != 0.0) ? vertical : top,
            left: (horizontal != 0.0) ? horizontal : left,
            bottom: (vertical != 0.0) ? vertical : bottom,
            right: (horizontal != 0.0) ? horizontal : right
        )
    }
}

extension UIView {
    /// The constrain extension will optionally apply the fully qualified constriants to the view.
    /// Ideally supply any combination of parameters that results in
    /// position and size of the view to be constrained
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

        margin: UIEdgeInsets? = nil,
        padding: UIEdgeInsets = .zero,
        offset: UIEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        var constraintList: [NSLayoutConstraint] = []

        translatesAutoresizingMaskIntoConstraints = false

        let hasPinnedWidth = (left != nil && right != nil)
        let hasPinnedHeight = (top != nil && bottom != nil)

        if let margin = margin {
            layoutMargins = margin
        }

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
        if let widthConstraint = widthConstraint {
            constraintList.append(widthConstraint)
        }
        if let heightConstraint = heightConstraint {
            constraintList.append(heightConstraint)
        }

        if activate {
            NSLayoutConstraint.activate(constraintList)
        }
        return constraintList
    }

    @discardableResult
    func constrain(
        activate: Bool = true,
        to: UIView,
        padding: UIEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        return constrain(
            activate: activate,
            top: to.topAnchor,
            left: to.leftAnchor,
            bottom: to.bottomAnchor,
            right: to.rightAnchor,
            padding: padding
        )
    }

    func removeAll() {
        for subview in self.subviews {
            subview.removeConstraints()
            subview.removeFromSuperview()
        }
    }

    func removeConstraints() {
        let constraints = self.superview?.constraints.filter {
            $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
        } ?? []

        self.superview?.removeConstraints(constraints)
        self.removeConstraints(self.constraints)
    }
}
