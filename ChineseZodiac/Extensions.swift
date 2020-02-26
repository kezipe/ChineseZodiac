//
//  CustomDateFormatter.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-06-03.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation

extension Date {
  init(fromYear year: Int, month: Int, day: Int) {
    var normalCalendarDateComponents = DateComponents()
    normalCalendarDateComponents.year = year
    normalCalendarDateComponents.month = month
    normalCalendarDateComponents.day = day
    
    let normalCalendar = Calendar(identifier: .gregorian)
    self = normalCalendar.date(from: normalCalendarDateComponents)!
  }
  
  func convertToChineseDate() -> String {
    let chineseCalendar = Calendar(identifier: .chinese)
    let formatter = DateFormatter()
    formatter.calendar = chineseCalendar
    formatter.dateStyle = .long
    let chineseDate = formatter.string(from: self)
    return chineseDate
  }
  
  func branch() -> String {
    let chineseDate = self.convertToChineseDate()
    guard let hyphen = chineseDate.firstIndex(of: "-") else {
      fatalError("\(chineseDate) is not correctly formatted, use DateFormatter.Style.full")
    }
    
    let startIndex = chineseDate.index(after: hyphen)
    let endIndex = chineseDate.index(chineseDate.endIndex, offsetBy: -2)
    let branchExtracted = chineseDate[startIndex ... endIndex]
    
    return String(branchExtracted)
  }
  
  func getZodiacRank() -> Int {
    let branches = [
      "zi",
      "chou",
      "yin",
      "mao",
      "chen",
      "si",
      "wu",
      "wei",
      "shen",
      "you",
      "xu",
      "hai"
    ]
    let dateBranch = branch()
    let index = branches.firstIndex(of: dateBranch)!
    return index + 1
  }
  
  func getZodiac() -> Zodiac {
    let rank = getZodiacRank()
    return Zodiac(rawValue: rank - 1)!
  }
  
  func getStemBranch() -> String {
    let chineseDate = self.convertToChineseDate()
    let leftBracketIndex = chineseDate.firstIndex(of: "(")!
    let startIndex = chineseDate.index(leftBracketIndex, offsetBy: 1)
    let endIndex = chineseDate.index(chineseDate.endIndex, offsetBy: -2)
    let stemBranch = chineseDate[startIndex ... endIndex]
    
    return String(stemBranch)
  }
  
  func getChineseADYear() -> Int {
    let formattedDate = self.convertToChineseDate()
    
    let comma = formattedDate.firstIndex(of: ",")!
    let startIndex = formattedDate.index(comma, offsetBy: 2)
    let endIndex = formattedDate.firstIndex(of: "(")!
    let year = formattedDate[startIndex ..< endIndex]
    return Int(year)!
  }
  
  func formatChineseCalendarDate() -> String{
    let chineseCalendar = Calendar(identifier: .chinese)
    let month = chineseCalendar.dateComponents([.month], from: self).month
    let day = chineseCalendar.dateComponents([.day], from: self).day
    let year = self.getChineseADYear()
    return "Month \(month!) Day \(day!), \(year)"
  }
  
  func getYellowEmperorYear() -> Int {
    return self.getChineseADYear() + 2698
  }
  
  func getChineseCalendarMonth() -> Int {
    let chineseCalendar = Calendar(identifier: .chinese)
    let month = chineseCalendar.dateComponents([.month], from: self).month
    return Int(month!)
  }
  
  func getChineseCalendarDay() -> Int {
    let chinese = Calendar(identifier: .chinese)
    let day = chinese.dateComponents([.day], from: self).day
    return Int(day!)
  }
  
  func getLunarMonth() -> String {
    let dict: [Int: String] = [
      1: "1st – 寅 (yin) Tiger",
      2: "2nd – 卯 (mao) Rabbit",
      3: "3rd – 辰 (chen) Dragon",
      4: "4th – 巳 (si) Snake",
      5: "5th – 午 (wu) Horse",
      6: "6th – 未 (wei) Goat",
      7: "7th – 申 (shen) Monkey",
      8: "8th – 酉 (you) Rooster",
      9: "9th – 戌 (xu) Dog",
      10: "10th – 亥 (hai) Pig",
      11: "11th – 子 (zi) Rat",
      12: "12th – 丑 (chou) Ox"
    ]
    return dict[self.getChineseCalendarMonth()]!
  }
  
  func getSolarTerm() -> String {
    let dayLocationIsInitial = self.getChineseCalendarDay() < 15
    let chineseCalendarMonth = self.getChineseCalendarMonth()
    if dayLocationIsInitial {
      let solarTerm = [11:"daxue (大雪)",
                       12:"xiaohan (小寒)",
                       1:"lichun (立春)",
                       2:"jingzhe (惊蛰)",
                       3:"qingming (清明)",
                       4:"lixia (立夏)",
                       5:"mangzhong (芒种)",
                       6:"xiaoshu (小暑)",
                       7:"liqiu (立秋)",
                       8:"bailu (白露)",
                       9:"hanlu (寒露)",
                       10:"lidong (立冬)"]
      return solarTerm[chineseCalendarMonth]!
    } else {
      let solarTerm = [11:"dongzhi (冬至)",
                       12:"dahan (大寒)",
                       1:"yushui (雨水)",
                       2:"chunfen (春分)",
                       3:"guyu (谷雨)",
                       4:"xiaoman (小满)",
                       5:"xiazhi (夏至)",
                       6:"dashu (大暑)",
                       7:"chushu (处暑)",
                       8:"qiufen (秋分)",
                       9:"shuangjiang (霜降)",
                       10:"xiaoxue (小雪)"]
      return solarTerm[chineseCalendarMonth]!
    }
  }
  
  func getSeason() -> String {
    let chineseCalendarMonth = self.getChineseCalendarMonth()
    
    switch chineseCalendarMonth {
    case 1 ..< 4:
      return "Spring"
    case 4 ..< 7:
      return "Summer"
    case 7 ..< 10:
      return "Autumn"
    default:
      return "Winter"
    }
  }
  
  func getFixedElement() -> String {
    let chineseCalendarMonth = self.getChineseCalendarMonth()
    
    switch chineseCalendarMonth {
    case 3, 6, 9, 12:
      return "Earth"
    case 1, 2:
      return "Wood"
    case 4, 5:
      return "Fire"
    case 7, 8:
      return "Metal"
    case 10, 11:
      return "Water"
    default:
      return "No Fixed Element"
    }
  }
  
  static func numberOfDaysInMonth(_ month: Int, in year: Int) -> Int {
    let dateComponents = DateComponents(year: year, month: month)
    let calendar = Calendar.current
    let date = calendar.date(from: dateComponents)!
    let range = calendar.range(of: .day, in: .month, for: date)!
    return range.count
  }
}

extension Int {
  func toMonthName() -> String {
    let df = DateFormatter()
    df.dateFormat = "MM"
    return df.monthSymbols[self - 1]
  }
}
