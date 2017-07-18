//
//  PublicFunctions.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation

class Helper {
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
