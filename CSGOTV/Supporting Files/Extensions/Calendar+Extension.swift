//
//  Calendar+Extension.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import Foundation
import UIKit

extension Calendar {
  func isDateInThisWeek(_ date: Date) -> Bool {
    return isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
  }
}

extension DateComponents {
    private var weekdays: [String] {
        [
            "weekday.sunday".localized,
            "weekday.monday".localized,
            "weekday.tuesday".localized,
            "weekday.wednesday".localized,
            "weekday.thursday".localized,
            "weekday.friday".localized,
            "weekday.saturday".localized
            
        ]
    }
    
    func dayOfWeek() -> String {
        weekdays[(self.weekday ?? 1) - 1]
    }
    
    func formattedHour() -> String {
        if let date = Calendar.current.date(from: self) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH':'mm"
            return formatter.string(from: date)
        }
        return ""
    }
    
    func formattedDayMonth() -> String {
        if let date = Calendar.current.date(from: self) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd'.'MM"
            return formatter.string(from: date)
        }
        return ""
    }
}
