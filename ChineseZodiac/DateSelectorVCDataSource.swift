//
//  DateSelectorVCDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation

class DateSelectorVCDataSource: PickerViewDataSource {
  var dateComponentsSelected = DateComponents()
  var dateComponentsSelectionMode = DateComponentSelectionMode.month
  
  func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
    switch dateComponentsSelectionMode {
    case .month:
      return showMonthsCount()
    case .day:
      return showDayCount()
    case .year:
      return showYearCount()
    }
  }
  
  func showMonthsCount() -> Int {
    return 12
  }
  
  func showDayCount() -> Int {
    return calculateNumberOfDays()
  }
  
  func showYearCount() -> Int {
    return 2100
  }
  
  func calculateNumberOfDays() -> Int {
    if let months = dateComponentsSelected.month {
      let year: Int!
      if let years = dateComponentsSelected.year {
        year = years
      } else {
        year = 2000
      }
      return Date.numberOfDaysInMonth(months, in: year)
    } else {
      return 31
    }
  }
  
  func pickerView(_ pickerView: PickerView, titleForRow row: Int) -> String {
    switch dateComponentsSelectionMode {
    case .month:
      return showMonthTitle(for: row)
    case .day:
      return showDayTitle(for: row)
    case .year:
      return showYearTitle(for: row)
    }
  }
  
  func showMonthTitle(for row: Int) -> String {
    (row + 1).toMonthName()
  }
  
  func showDayTitle(for row: Int) -> String {
    "\(row + 1)"
  }
  
  func showYearTitle(for row: Int) -> String {
    "\(row + 1)"
  }
}



