//
//  UIView.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

extension UIView {
	public var parentViewController: UIViewController? {
		var parentResponder: UIResponder? = self
		while parentResponder != nil {
			parentResponder = parentResponder!.next
			if let viewController = parentResponder as? UIViewController {
				return viewController
			}
		}
		return nil
	}

	public func windowRect() -> CGRect? {
		return superview?.convert(frame, to: nil)
	}

	public func addVisualConstraint(_ withVisualFormat: String, views: UIView...) {
		var viewsDictionary = [String: UIView]()

		for (index, view) in views.enumerated() {
			let key = "v\(index)"
			view.translatesAutoresizingMaskIntoConstraints = false
			viewsDictionary[key] = view
		}

		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withVisualFormat, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
	}

	public func isInViewHierarchy() -> Bool {
		if self.superview != nil {
			return true
		} else {
			return false
		}
	}

	@discardableResult
	public func loadFromNib<T: UIView>() -> T? {
		guard let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
			return nil
		}
		self.addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = true
		contentView.frame = bounds
		contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		return contentView
	}
}
