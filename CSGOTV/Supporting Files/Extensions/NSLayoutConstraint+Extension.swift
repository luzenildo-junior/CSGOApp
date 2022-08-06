//
//  NSLayoutConstraint+Extension.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
