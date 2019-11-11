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
        for c in newFormattedDate.enumerated() {
            let stringChar = String(c.element)
            if stringChar.rangeOfCharacter(from:numberCharacters) == nil {
                break
            }
            index += 1
        }
        let zodiac = newFormattedDate.index(newFormattedDate.startIndex, offsetBy: index + 1)
        return "\(newFormattedDate[zodiac])"
    }
    
    func getZodiacRank() -> Int {
        let zodiacRank = ["子":1, "丑":2,"寅":3, "卯":4,"辰":5, "巳":6,"午":7, "未":8,"申":9, "酉":10,"戌":11, "亥":12]
        return zodiacRank[self.getZodiacChar()]!
    }
    
    func getZodiac() -> String {
        let zodiacCharToZodiac = ["子":"Rat", "丑":"Ox", "寅":"Tiger", "卯":"Rabbit", "辰":"Dragon", "巳":"Snake",
                                  "午":"Horse", "未":"Goat", "申":"Monkey", "酉":"Rooster", "戌":"Dog", "亥":"Pig"]
        return zodiacCharToZodiac[self.getZodiacChar()]!
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
        if let idx = formattedDate.firstIndex(of: comma) {
            pos = formattedDate.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos = 0
        }
        let index = formattedDate.index(formattedDate.startIndex, offsetBy: pos! + 2)
        let yearWithStemBranch = formattedDate[index...]
        
        // Year with Stem Branch separated:
        let leftBracket: Character = "("
        let pos2: Int?
        if let idx = yearWithStemBranch.firstIndex(of: leftBracket) {
            pos2 = yearWithStemBranch.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos2 = 0
        }
        let index2 = yearWithStemBranch.index(formattedDate.startIndex, offsetBy: pos2!)
        let stemBranchWithBrackets = yearWithStemBranch[index2...]
        let range = stemBranchWithBrackets.index(stemBranchWithBrackets.startIndex, offsetBy: 1)..<stemBranchWithBrackets.index(stemBranchWithBrackets.endIndex, offsetBy: -1)
        let stemBranch = stemBranchWithBrackets[range]
        
        return String(stemBranch)
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
        if let idx = formattedDate.firstIndex(of: comma) {
            pos = formattedDate.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos = 0
        }
        let index = formattedDate.index(formattedDate.startIndex, offsetBy: pos! + 2)
        let yearWithStemBranch = formattedDate[index...]
        
        // Year with Stem Branch separated:
        let leftBracket: Character = "("
        let pos2: Int?
        if let idx = yearWithStemBranch.firstIndex(of: leftBracket) {
            pos2 = yearWithStemBranch.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos2 = 0
        }
        let index2 = yearWithStemBranch.index(formattedDate.startIndex, offsetBy: pos2!)
        let year = yearWithStemBranch[..<index2]
        
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
        if let idx = formattedDate.firstIndex(of: comma) {
            pos = formattedDate.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos = 0
        }
        let index = formattedDate.index(formattedDate.startIndex, offsetBy: pos! + 2)
        let yearWithStemBranch = formattedDate[index...]
        
        // Year with Stem Branch separated:
        let leftBracket: Character = "("
        let pos2: Int?
        if let idx = yearWithStemBranch.firstIndex(of: leftBracket) {
            pos2 = yearWithStemBranch.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos2 = 0
        }
        let index2 = yearWithStemBranch.index(formattedDate.startIndex, offsetBy: pos2! - 1)
        
        return Int(yearWithStemBranch[...index2])! + 2697
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
        let lMonth: [Int: String] = [
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
            let solarTerm = [11:"daxue (大雪)", 12:"xiaohan (小寒)", 1:"lichun (立春)", 2:"jingzhe (惊蛰)", 3:"qingming (清明)", 4:"lixia (立夏)",
                             5:"mangzhong (芒种)", 6:"xiaoshu (小暑)", 7:"liqiu (立秋)", 8:"bailu (白露)", 9:"hanlu (寒露)", 10:"lidong (立冬)"]
            return solarTerm[self.getCMonth()]!
        } else {
            let solarTerm = [11:"dongzhi (冬至)", 12:"dahan (大寒)", 1:"yushui (雨水)", 2:"chunfen (春分)", 3:"guyu (谷雨)", 4:"xiaoman (小满)",
                             5:"xiazhi (夏至)", 6:"dashu (大暑)", 7:"chushu (处暑)", 8:"qiufen (秋分)", 9:"shuangjiang (霜降)", 10:"xiaoxue (小雪)"]
            return solarTerm[self.getCMonth()]!
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
    
    func getFixedElement() -> String {
        let cMonth = self.getCMonth()
        
        switch cMonth {
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
