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
    
    func getZodiacRank() -> Int16 {
        switch self.getZodiacChar() {
        case "子":
            return 1
        case "丑":
            return 2
        case "寅":
            return 3
        case "卯":
            return 4
        case "辰":
            return 5
        case "巳":
            return 6
        case "午":
            return 7
        case "未":
            return 8
        case "申":
            return 9
        case "酉":
            return 10
        case "戌":
            return 11
        case "亥":
            return 12
        default:
            return 0
        }
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
    
    func getCMonth() -> Int {
        let dateFormatter = DateFormatter()
        let chinese = Calendar(identifier: Calendar.Identifier.chinese)
        dateFormatter.calendar = chinese
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.dateStyle = .long
        // Month
        let month = chinese.dateComponents([.month], from: self).month
        return Int(month!)
    }
    
    func getCDay() -> Int {
        let dateFormatter = DateFormatter()
        let chinese = Calendar(identifier: Calendar.Identifier.chinese)
        dateFormatter.calendar = chinese
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.dateStyle = .long
        // Month
        let day = chinese.dateComponents([.day], from: self).day
        return Int(day!)
    }
    
    func getLunarMonth() -> String {
        var lMonth: [Int: String] = [
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
        return lMonth[self.getCMonth()]!
    }
    
    func getSolarTerm() -> String {
        let dayLocationIsInitial = self.getCDay() < 15 ? true : false
        
        if dayLocationIsInitial {
            switch self.getCMonth() {
            case 11:
                return "大雪 dàxuě"
            case 12:
                return "小寒 xiǎohán"
            case 1:
                return "立春 lìchūn"
            case 2:
                return "惊蛰 jīngzhé"
            case 3:
                return "清明 qīngmíng"
            case 4:
                return "立夏 lìxià"
            case 5:
                return "芒种 mángzhòng"
            case 6:
                return "小暑 xiǎoshǔ"
            case 7:
                return "立秋 lìqiū"
            case 8:
                return "白露 báilù"
            case 9:
                return "寒露 hánlù"
            case 10:
                return "立冬 lìdōng"
            default:
                return ""
            }
        } else {
            switch self.getCMonth() {
            case 11:
                return "冬至 dōngzhì"
            case 12:
                return "大寒 dàhán"
            case 1:
                return "雨水 yǔshuǐ"
            case 2:
                return "春分 chūnfēn"
            case 3:
                return "谷雨 gǔyǔ"
            case 4:
                return "小满 xiǎomǎn"
            case 5:
                return "夏至 xiàzhì"
            case 6:
                return "大暑 dàshǔ"
            case 7:
                return "处暑 chǔshǔ"
            case 8:
                return "秋分 qiūfēn"
            case 9:
                return "霜降 shuāngjiàng"
            case 10:
                return "小雪 xiǎoxuě"
            default:
                return ""
            }
        }
    }
    
    func getSeason() -> String {
        let cMonth = self.getCMonth()

        if cMonth < 4 {
            return "Spring"
        } else if cMonth > 4 && cMonth < 7 {
            return "Summer"
        } else if cMonth > 7 && cMonth < 10 {
            return "Autumn"
        } else {
            return "Winter"
        }
    }
    
    
    
}

extension Int {
    func toMonthName() -> String {
        let df = DateFormatter()
        df.dateFormat = "MM"
        return df.monthSymbols[self - 1]
    }
    
    func toNumDaysInMonth(year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: self)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
}
