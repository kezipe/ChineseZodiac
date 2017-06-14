//: Playground - noun: a place where people can play

import UIKit

let birthDay = 1
let birthMonth = 6
let birthYear = 2017
var gBirthdayDateComponents = DateComponents()
gBirthdayDateComponents.year = birthYear
gBirthdayDateComponents.month = birthMonth
gBirthdayDateComponents.day = birthDay
gBirthdayDateComponents.timeZone = TimeZone(abbreviation: "EDT")
//gBirthdayDateComponents.timeZone = TimeZone(identifier: "UTC+0800")

let calendar = Calendar.current
let chinese = Calendar(identifier: Calendar.Identifier.chinese)
let formatter = DateFormatter()
formatter.dateStyle = .full
formatter.timeStyle = .short
formatter.calendar = chinese
formatter.locale = Locale(identifier: "zh_CN")
let date = calendar.date(from: gBirthdayDateComponents)


print(formatter.string(from: date!))


print(chinese.dateComponents([.year], from: date!))


//print(chinese.dateComponents([.year], from: date!))

var stems: [Int: Character] = [
    0 : "甲",
    1 : "乙",
    2 : "丙",
    3 : "丁",
    4 : "戊",
    5 : "己",
    6 : "庚",
    7 : "辛",
    8 : "壬",
    9 : "癸"
]

var branches: [Int: Character] = [
    0: "子",
    1: "丑",
    2: "寅",
    3: "卯",
    4: "辰",
    5: "巳",
    6: "午",
    7: "未",
    8: "申",
    9: "酉",
    10: "戌",
    11: "亥"
]

func toCY(year: Int) {
    let r = (year - 4) % 12
    print(stems[r < 10 ? r : r % 10]!, branches[r < 12 ? r : r % 12]!)
}

toCY(year: 2004)

var counter = 1984
for i in 0..<60 {
    print(counter, stems[i < 10 ? i : i % 10]!, branches[i < 12 ? i : i % 12]!)
    counter += 1
}







