//
//  String+Localization.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

/// Localization
extension String {
    var localized: String {
        func localize(key: String) -> String {
            NSLocalizedString(key, comment: "")
        }
        return localize(key: self)
    }
}

/// Date
extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}
