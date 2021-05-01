import XCTest
@testable import Zodiacs

final class ChineseZodiacsTest: XCTestCase {
    func testDateToChineseZodiacConversion_ShouldBeDog() {
        let date = DateComponents(calendar: .init(identifier: .gregorian), year: 1994, month: 4, day: 8).date!
        let result = ChineseZodiac(date: date)
        let expectation = ChineseZodiac.dog
        XCTAssertEqual(result, expectation)
    }

    func testDateToChineseZodiacConversion_ShouldBeGoat() {
        let date = DateComponents(calendar: .init(identifier: .gregorian), year: 1991, month: 6, day: 29).date!
        let result = ChineseZodiac(date: date)
        let expectation = ChineseZodiac.goat
        XCTAssertEqual(result, expectation)
    }
}
