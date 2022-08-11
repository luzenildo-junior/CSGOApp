//
//  MatchDateParser.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import Foundation

enum MatchDateParser: Equatable {
    case today(hour: String)
    case thisWeek(day: String, hour: String)
    case future(day: String, hour: String)
    case unknown
}

extension MatchDateParser {
    init(with date: Date?) {
        guard let date = date else {
            self = .unknown
            return
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .weekday, .hour, .minute], from: date)
        if calendar.isDateInToday(date) {
            self = .today(hour: components.formattedHour())
        } else if calendar.isDateInThisWeek(date) {
            self = .thisWeek(day: components.dayOfWeek(), hour: components.formattedHour())
        } else {
            self = .future(day: components.formattedDayMonth(), hour: components.formattedHour())
        }
    }
    
    func toString() -> String {
        switch self {
        case .today(let hour):
            return "weekday.today".localized + ", " + hour
        case .thisWeek(let day, let hour):
            return "\(day), \(hour)"
        case .future(let day, let hour):
            return "\(day) \(hour)"
        case .unknown:
            return "TBD"
        }
    }
}
