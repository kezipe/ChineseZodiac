//
//  CustomDateFormatter.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-06-03.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation

extension Date {
    
    
    func format(calendarId: Calendar.Identifier, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.calendar = Calendar(identifier: calendarId)
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
            return "Goat"
        case "申":
            return "Monkey"
        case "酉":
            return "Rooster"
        case "戌":
            return "Dog"
        case "亥":
            return "Pig"
        default:
            return ""
        }
    }
    
    func getStemBranch() -> String {
        let dateFormatter = DateFormatter()
        let chinese = Calendar(identifier: Calendar.Identifier.chinese)
        dateFormatter.calendar = chinese
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.dateStyle = .long
        let formattedDate = dateFormatter.string(from: self)
        
        // Isolate for Year and Stem Branch
        let comma: Character = ","
        let pos: Int?
        if let idx = formattedDate.characters.index(of: comma) {
            pos = formattedDate.characters.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos = 0
        }
        let index = formattedDate.index(formattedDate.startIndex, offsetBy: pos! + 2)
        let yearWithStemBranch = formattedDate.substring(from: index)
        
        // Year with Stem Branch separated:
        let leftBracket: Character = "("
        let pos2: Int?
        if let idx = yearWithStemBranch.characters.index(of: leftBracket) {
            pos2 = yearWithStemBranch.characters.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos2 = 0
        }
        let index2 = yearWithStemBranch.index(formattedDate.startIndex, offsetBy: pos2!)
        let stemBranchWithBrackets = yearWithStemBranch.substring(from: index2)
        let range = stemBranchWithBrackets.index(stemBranchWithBrackets.startIndex, offsetBy: 1)..<stemBranchWithBrackets.index(stemBranchWithBrackets.endIndex, offsetBy: -1)
        let stemBranch = stemBranchWithBrackets.substring(with: range)
        
        return stemBranch
    }
    
    func formatChineseCalendarDate() -> String{
        let dateFormatter = DateFormatter()
        let chinese = Calendar(identifier: Calendar.Identifier.chinese)
        dateFormatter.calendar = chinese
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.dateStyle = .long
        let formattedDate = dateFormatter.string(from: self)
        
        // Isolate for Year and Stem Branch
        let comma: Character = ","
        let pos: Int?
        if let idx = formattedDate.characters.index(of: comma) {
            pos = formattedDate.characters.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos = 0
        }
        let index = formattedDate.index(formattedDate.startIndex, offsetBy: pos! + 2)
        let yearWithStemBranch = formattedDate.substring(from: index)
        
        // Year with Stem Branch separated:
        let leftBracket: Character = "("
        let pos2: Int?
        if let idx = yearWithStemBranch.characters.index(of: leftBracket) {
            pos2 = yearWithStemBranch.characters.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos2 = 0
        }
        let index2 = yearWithStemBranch.index(formattedDate.startIndex, offsetBy: pos2!)
        let year = yearWithStemBranch.substring(to: index2)
        
        // Month and Day
        let month = chinese.dateComponents([.month], from: self).month
        let day = chinese.dateComponents([.day], from: self).day
        return "Month \(month!) Day \(day!), \(year)"
    }
    
    func getAhYear() -> Int {
        let dateFormatter = DateFormatter()
        let chinese = Calendar(identifier: Calendar.Identifier.chinese)
        dateFormatter.calendar = chinese
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.dateStyle = .long
        let formattedDate = dateFormatter.string(from: self)
        
        // Isolate for Year and Stem Branch
        let comma: Character = ","
        let pos: Int?
        if let idx = formattedDate.characters.index(of: comma) {
            pos = formattedDate.characters.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos = 0
        }
        let index = formattedDate.index(formattedDate.startIndex, offsetBy: pos! + 2)
        let yearWithStemBranch = formattedDate.substring(from: index)
        
        // Year with Stem Branch separated:
        let leftBracket: Character = "("
        let pos2: Int?
        if let idx = yearWithStemBranch.characters.index(of: leftBracket) {
            pos2 = yearWithStemBranch.characters.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos2 = 0
        }
        let index2 = yearWithStemBranch.index(formattedDate.startIndex, offsetBy: pos2!)
        return Int(yearWithStemBranch.substring(to: index2))! + 2697
    }
    
}
