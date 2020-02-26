//
//  ChineseZodiacTests.swift
//  ChineseZodiacTests
//
//  Created by Kevin Peng on 2020-02-25.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import XCTest
@testable import ChineseZodiac

class ChineseZodiacTests: XCTestCase {

  func testDateCreation() {
    let aDate = Date(fromYear: 1991, month: 6, day: 22)
    let dateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 1991, month: 6, day: 22)
    let correctDate = dateComponents.date!
    
    XCTAssertEqual(correctDate, aDate)
  }
  
  func testZodiacString() {
    let aDate = Date(fromYear: 2020, month: 5, day: 1)
    let result = aDate.branch()
    let expected = "zi"
    XCTAssertEqual(result, expected)
  }
  
  func testStemBranchRefactor() {
    let aDate = Date(fromYear: 2020, month: 5, day: 1)
    let result = aDate.getStemBranch()
    let expected = "geng-zi"
    XCTAssertEqual(result, expected)
  }
  
  func testFormattedChineseDate() {
    let aDate = Date(fromYear: 2020, month: 5, day: 1)
    let result = aDate.formatChineseCalendarDate()
    let expected = "Month 4 Day 9, 2020"
    XCTAssertEqual(result, expected)
  }
  
  func testAhYear() {
    let aDate = Date(fromYear: 1979, month: 7, day: 14)
    let result = aDate.getYellowEmperorYear()
    let expected = 4677
    XCTAssertEqual(result, expected)
  }
  
  func testAhYear2() {
    let aDate = Date(fromYear: 2020, month: 2, day: 26)
    let result = aDate.getYellowEmperorYear()
    let expected = 4718
    XCTAssertEqual(result, expected)
  }
  
  func testAhYear3() {
    let aDate = Date(fromYear: 2020, month: 1, day: 1)
    let result = aDate.getYellowEmperorYear()
    let expected = 4717
    XCTAssertEqual(result, expected)
  }

}
