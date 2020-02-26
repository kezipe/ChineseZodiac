//
//  Match.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-26.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation

struct Match: Comparable {
  var firstPerson: Person
  var secondPerson: Person
  var compatibility: Int
  
  var isAlone: Bool {
    firstPerson.isPlaceholder || secondPerson.isPlaceholder
  }
  
  var loner: Person? {
    guard isAlone else {
      return nil
    }
    
    if firstPerson.isPlaceholder {
      return secondPerson
    } else {
      return firstPerson
    }
  }
  
  var compatibilityName: String {
    let compatibilityName = [
      1:"Poor",
      2:"Average",
      3:"Good match or Enemy",
      4:"Good friend",
      5:"Complementary",
      6: "Perfect Match"
    ]
    return compatibilityName[compatibility, default: ""]
  }
  
  static func <(lhs: Match, rhs: Match) -> Bool {
    return lhs.compatibility > rhs.compatibility
  }
}
