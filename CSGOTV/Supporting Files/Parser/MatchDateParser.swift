//
//  MatchDateParser.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import Foundation

enum MatchDateParser {
    case today(hour: String)
    case thisWeek(day: String, hour: String)
    case future(day: String, hour: String)
    case unknown
}

extension MatchDateParser {
    init(dateStr: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        if let date = dateFormatter.date(from: dateStr) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: date)
            if calendar.isDateInToday(date) {
                self = .today(hour: components.formattedHour())
                return
            } else if calendar.isDateInThisWeek(date) {
                self = .thisWeek(day: components.dayOfWeek(), hour: components.formattedHour())
                return
            } else {
                self = .future(day: components.formattedDayMonth(), hour: components.formattedHour())
                return
            }
        }
        self = .unknown
    }
    
    func toString() -> String {
        switch self {
        case .today(let hour):
            return "hoje, " + hour
        case .thisWeek(let day, let hour):
            return "\(day), \(hour)"
        case .future(let day, let hour):
            return "\(day) \(hour)"
        case .unknown:
            return "TBD"
        }
    }
}
