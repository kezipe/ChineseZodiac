//
//  Match.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData



class Matcher {
  var personsArray: [Person]

  
  fileprivate func insertDummyPerson() {
    let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
    let p = Person.init(entity: entityDescription!, insertInto: nil)
    p.zodiac = 13
    p.name = ""
    personsArray.append(p)
  }
  
  init(personsArray: [Person]) {
    self.personsArray = personsArray
    
    if personsArray.count % 2 != 0 {
      insertDummyPerson()
    }
  }
  
  func matchUp() -> [Match] {
    let pairedPersons = pair(personsArray)
    return findBestScenario(pairedPersons)
  }
  
  fileprivate func pair(_ arr: [Person]) -> [[Person]] {
    var bigA = [[Person]]()
    if arr.count == 2 {
      return [arr]
    }
    
    var firstTwo = Array(arr[...(arr.startIndex + 1)])
    var rest = Array(arr[(arr.startIndex + 2)...])
    var list: [[Person]]
    for i in 0...rest.count {
      list = pair(rest)
      for j in list {
        bigA.append(firstTwo + j)
      }
      
      guard i < rest.count else { continue }
      let tempFirst = firstTwo[firstTwo.endIndex - 1]
      firstTwo[firstTwo.endIndex - 1] = rest[i]
      rest[i] = tempFirst
    }
    return bigA
  }
  
  fileprivate func findBestScenario(_ pairedPersons: [[Person]]) -> [Match] {
    var bestMatchScore = 0
    var bestMatch = [Match]()
    
    for i in 0..<pairedPersons.count {
      var tempScore = 0
      var tempMatch = [Match]()
      
      for j in stride(from: 0, to: pairedPersons[0].count - 1, by: 2) {
        let person1 = pairedPersons[i][j]
        let person2 = pairedPersons[i][j + 1]
        
        let person1Zodiac = person1.zodiacSign
        let person2Zodiac = person2.zodiacSign
        
        let matchScore = Zodiac.match(person1Zodiac, with: person2Zodiac)
        let match = Match(firstPerson: person1, secondPerson: person2, compatibility: matchScore)
        
        tempScore += matchScore
        tempMatch.append(match)
      }
      
      if bestMatch.isEmpty || bestMatchScore < tempScore {
        bestMatchScore = tempScore
        bestMatch = tempMatch
      }
    }
    return bestMatch
  }

  
  
}
