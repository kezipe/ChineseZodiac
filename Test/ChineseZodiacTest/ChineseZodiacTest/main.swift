//
//  main.swift
//  ChineseZodiacTest
//
//  Created by Kevin on 2017-06-29.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation

extension Date {
    func format(calendarId: Calendar.Identifier) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        dateFormatter.calendar = Calendar(identifier: calendarId)
        print(calendarId)
        if calendarId == Calendar.Identifier.chinese {
            return dateFormatter.string(from: self.toChinese())
        } else {
            return dateFormatter.string(from: self)
        }
    }
    
    func toChinese() -> Date {
        let chinese = Calendar(identifier: Calendar.Identifier.chinese)
        var dateComponents = DateComponents()
        dateComponents.year = chinese.component(.year, from: self)
        dateComponents.month = chinese.component(.month, from: self)
        dateComponents.day = chinese.component(.day, from: self)
        return chinese.date(from: dateComponents)!
    }
    
    func getZodiacChar() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.chinese)
        let newFormattedDate = dateFormatter.string(from: self)
        let numberCharacters = CharacterSet.decimalDigits
        var index = 0
        for c in newFormattedDate.characters.enumerated() {
            let stringChar = String(c.element)
            if stringChar.rangeOfCharacter(from:numberCharacters) == nil {
                break
            }
            index += 1
        }
        let zodiac = newFormattedDate.index(newFormattedDate.startIndex, offsetBy: index + 1)
        return "\(newFormattedDate[zodiac])"
    }
    
    func getZodiac() -> String {
        switch self.getZodiacChar() {
        case "子":
            return "Rat"
        case "丑":
            return "Ox"
        case "寅":
            return "Tiger"
        case "卯":
            return "Rabbit"
        case "辰":
            return "Dragon"
        case "巳":
            return "Snake"
        case "午":
            return "Horse"
        case "未":
            return "Ram"
        case "申":
            return "Monkey"
        case "酉":
            return "Rooster"
        case "戌":
            return "Dog"
        case "亥":
            return "Pig/Boar"
        default:
            return ""
        }
    }
}

let calendar = Calendar.current
var dateComp = DateComponents()
dateComp.year = 10000
dateComp.month = 1
dateComp.day = 1
let date = calendar.date(from: dateComp)!
print(date.getZodiac())
