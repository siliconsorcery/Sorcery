//
//  UIStackView_RemoveAll.swift
//  Sorcery
//
//  Created by John Cumming on 10/19/19.
//  Copyright © 2019 Silicon Sorcery. All rights reserved.
//

import UIKit

extension UIStackView {
    func add(arrangedSubviewList: [UIView]) {
        for view in arrangedSubviewList {
            addArrangedSubview(view)
        }
    }
    
    func replace(arrangedSubviewList: [UIView]) {
        removeAllArrangedSubviews()
        for view in arrangedSubviewList {
            addArrangedSubview(view)
        }
    }
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }

    func removeFirstArrangedView() {
        for item in arrangedSubviews {
            removeArrangedSubview(item)
            item.removeFromSuperview()
            break
        }
    }
    
    func removeLastArrangedView() {
        if arrangedSubviews.isEmpty == false {
            let item = arrangedSubviews[arrangedSubviews.count - 1]
            removeArrangedSubview(item)
            item.removeFromSuperview()
        }
        
//        var index = 1
//        for item in arrangedSubviews {
//            if index == arrangedSubviews.count {
//                removeArrangedSubview(item)
//                item.removeFromSuperview()
//            }
//            index += 1
//        }
    }
}
