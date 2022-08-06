//
//  UITableView+Extension.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    // insert cell identifier describing cell class name to register and dequeue cells.
    static var cellIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    // Generic method to register table view cells only with the T type.
    func register<T: UITableViewCell>(type: T.Type) {
        self.register(type, forCellReuseIdentifier: type.cellIdentifier)
    }
    
    // Generic method to dequeue table view cells with T type and for a given indexPath, and returning the cell as type.
    func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, indexPath: IndexPath) -> T? {
        self.dequeueReusableCell(withIdentifier: type.cellIdentifier, for: indexPath) as? T
    }
}
