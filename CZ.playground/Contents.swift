//: Playground - noun: a place where people can play

import UIKit

let chinese = Calendar.Identifier.chinese

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
}

let now = Date()
print(now.format(calendarId:Calendar.Identifier.chinese))
