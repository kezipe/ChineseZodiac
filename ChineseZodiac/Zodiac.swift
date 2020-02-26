//
//  Zodiac.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation

enum Zodiac: Int {
  case rat
  case ox
  case tiger
  case rabbit
  case dragon
  case snake
  case horse
  case goat
  case monkey
  case rooster
  case dog
  case pig
  case alone
  
  var name: String {
    switch self {
    case .rat:
      return "Rat"
    case .ox:
      return "Ox"
    case .tiger:
      return "Tiger"
    case .rabbit:
      return "Rabbit"
    case .dragon:
      return "Dragon"
    case .snake:
      return "Snake"
    case .horse:
      return "Horse"
    case .goat:
      return "Goat"
    case .monkey:
      return "Monkey"
    case .rooster:
      return "Rooster"
    case .pig:
      return "Pig"
    case .dog:
      return "Dog"
    case .alone:
      return ""
    }
  }

  func findBestMatchedZodiacs() -> [Zodiac] {
    var bestMatches = [Zodiac]()
    for i in 0...12 {
      let testZodiac = Zodiac(rawValue: i)!
      let bestZodiac = Zodiac.match(self, with: testZodiac)
      if bestZodiac == 6 {
        bestMatches.append(testZodiac)
      }
    }
    return bestMatches
  }
  
  static func match(_ lhs: Zodiac, with rhs: Zodiac) -> Int {
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
    return match[lhs.rawValue][rhs.rawValue]
  }

}
