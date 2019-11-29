//
//  UIStoryboard.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery, MIT License. https://opensource.org/licenses/MIT
//

import UIKit

extension UIStoryboard {
	public class func loadViewController(from name: String? = "Root", indentifer: String? = nil) -> UIViewController? {
		guard name != nil else { return nil }
		let storyboard = UIStoryboard(name: name!, bundle: nil)
		if indentifer == nil {
			return storyboard.instantiateInitialViewController()
		} else {
			return storyboard.instantiateViewController(withIdentifier: indentifer!)
		}
	}
}
