//
//  String+Localization.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

extension String {
    var localized: String {
        func localize(key: String) -> String {
            NSLocalizedString(key, comment: "")
        }
        return localize(key: self)
    }
}
