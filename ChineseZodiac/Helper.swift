//
//  PublicFunctions.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

class Helper {
    static let color = UIColor(red: 1.0, green: 1.0, blue: 122.0/255, alpha: 1.0) // light-light yellow
    static let color2 = UIColor(red: 233.0/255, green: 160.0/255, blue: 52.0/255, alpha: 1.0) // dark orange
    static let color3 = UIColor(red: 216.0/255, green: 149.0/255, blue: 49.0/255, alpha: 1.0) // slightly darker orange
    static let color4 = UIColor(red: 1.0, green: 1.0, blue: 155.0/255, alpha: 1.0) // light-light-light yellow
    static let color5 = UIColor(red: 1.0, green: 1.0, blue: 102.0/255, alpha: 1.0) // light-yellow
    static let color6 = UIColor(red: 249.0/255, green: 211.0/255, blue: 65.0/255, alpha: 1.0) // light mango color
    
    static let colorBlack = UIColor(red: 0, green: 16.0/255, blue: 25.0/255, alpha: 1.0)
    static let colorBlue = UIColor(red: 69.0/255, green: 114.0/255, blue: 139.0/255, alpha: 1.0)
    static let colorRed = UIColor(red: 1.0, green: 54.0/255, blue: 97.0/255, alpha: 1.0)
    static let colorYellow = UIColor(red: 1.0, green: 221.0/255, blue: 53.0/255, alpha: 1.0)
    static let colorGreen = UIColor(red: 6/255, green: 201.0/255, blue: 155.0/255, alpha: 1.0)
    static let colorLightGreen = UIColor(red: 170.0/255, green: 240.0/255, blue: 223.0/255, alpha: 1.0)
    static let colorWhite = UIColor(red: 252.0/255, green: 252.0/255, blue: 252.0/255, alpha: 1.0)
    
    static func match(person1: Int, person2: Int) -> Int {
        let match = [[2,6,2,6,6,3,1,4,5,1,5,5,0],
                     [6,2,1,5,1,6,1,1,2,6,5,4,0],
                     [2,1,1,2,6,1,6,3,1,5,5,6,0],
                     [6,5,2,2,2,1,2,6,6,1,6,6,0],
                     [6,1,6,2,3,6,2,1,5,5,1,3,0],
                     [3,6,1,1,6,1,3,1,3,6,2,1,0],
                     [1,1,6,2,2,3,1,6,2,1,2,5,0],
                     [4,1,3,6,1,1,6,5,5,2,1,6,0],
                     [5,6,1,6,5,3,2,5,3,2,5,1,0],
                     [1,6,5,1,5,6,1,2,2,1,1,2,0],
                     [5,2,5,6,1,2,2,1,5,1,2,5,0],
                     [5,4,6,6,3,1,5,6,1,2,5,3,0],
                     [0,0,0,0,0,0,0,0,0,0,0,0,0]]
        return match[person1 - 1][person2 - 1]
    }
    
    static func getZodiac(fromIndex: Int) -> String {
        let zodiac = [1:"Rat", 2:"Ox", 3:"Tiger", 4:"Rabbit", 5:"Dragon", 6:"Snake", 7:"Horse", 8:"Goat", 9:"Monkey", 10:"Rooster", 11:"Dog", 12:"Pig"]
        return zodiac[fromIndex]!
    }
}
