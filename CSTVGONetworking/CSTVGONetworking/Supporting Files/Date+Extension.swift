//
//  Date+Extension.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 06/08/22.
//

import Foundation

extension Date {
    var twoDaysAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
    
    var next3Months: Date {
        return Calendar.current.date(byAdding: .month, value: 3, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var stringFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        return formatter.string(from: self)
    }
}
