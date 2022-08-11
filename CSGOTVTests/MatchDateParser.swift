//
//  MatchDateParser.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

@testable import CSGOTV
import XCTest

final class MatchDateParserTests: XCTestCase {
    func test_todayDate() {
        let noon = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        let dateParsed = MatchDateParser(with: noon).toString()
        
        XCTAssertEqual(dateParsed, "Hoje, 12:00")
    }
    
    func test_nextWeekDate() {
        let noon = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        let nextWeekDate = Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: noon)
        let dateParsed = MatchDateParser(with: nextWeekDate).toString()
        let components = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: nextWeekDate!)
        
        XCTAssertEqual(dateParsed, "\(components.formattedDayMonth()) \(components.formattedHour())")
    }
    
    func test_thisWeekDate() {
        let noon = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
        let thisWeekDate = Calendar.current.date(byAdding: .day, value: 2, to: noon)
        let dateParsed = MatchDateParser(with: thisWeekDate).toString()
        let components = Calendar.current.dateComponents([.weekday, .hour, .minute], from: thisWeekDate!)
        
        XCTAssertEqual(dateParsed, "\(components.dayOfWeek()), \(components.formattedHour())")
    }
    
    func test_unknownDate() {
        let dateParsed = MatchDateParser(with: nil).toString()
        
        XCTAssertEqual(dateParsed, "TBD")
    }
}
