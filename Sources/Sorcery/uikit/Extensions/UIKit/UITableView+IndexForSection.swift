//
//  UITableView+indexForSection.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

extension UITableView {
	func indexForSection(at location: CGPoint) -> Int? {
		// Find the section that we are dragging over
		let count = self.numberOfSections
		for index in 0...count - 1 {
			let rect = self.rect(forSection: index)
			if (location.y < rect.minY || location.y > rect.maxY ||
				location.x < rect.minX || location.x > rect.maxX) == false {
				return index
			}
		}
		// No section found
		return nil
	}
}
