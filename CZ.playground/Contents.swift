//: Playground - noun: a place where people can play

import UIKit

let chinese = Calendar.Identifier.chinese



var someDate = Date()
//now = now.toChinese()
let chineseCalendar = Calendar(identifier: chinese)
var dateComponents = DateComponents()
dateComponents.year = chineseCalendar.component(.year, from: someDate)
dateComponents.month = chineseCalendar.component(.month, from: someDate)
dateComponents.day = chineseCalendar.component(.day, from: someDate)
dateComponents.era = chineseCalendar.component(.era, from: someDate)
dateComponents.quarter = chineseCalendar.component(.quarter, from: someDate)
dateComponents.yearForWeekOfYear = chineseCalendar.component(.yearForWeekOfYear, from: someDate)

let newDate = Calendar.current.date(from: dateComponents)
if let newDate = newDate {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "zh_CN")
    dateFormatter.calendar = chineseCalendar
    let newFormattedDate = dateFormatter.string(from: newDate)
    let index = newFormattedDate.index(newFormattedDate.startIndex, offsetBy: 4)
    print(newFormattedDate[index])
    let zodiac = newFormattedDate.index(newFormattedDate.startIndex, offsetBy: 5)
    print(newFormattedDate[zodiac])
}
