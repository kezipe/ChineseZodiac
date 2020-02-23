//
//  Match.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData

class Match {
  
  var persons: [Person]?
  var personZodiacs: [Person]!
  var matchResultsInteger: [[Person]]?
  var matches: [[Person]]?
  var loner: Person?
  
  var perfectMatches = [[Person]]()
  var complimentary = [[Person]]()
  var goodFriend = [[Person]]()
  var gmoe = [[Person]]()
  var average = [[Person]]()
  var poor = [[Person]]()
  
  init(personsArray: [Person]) {
    self.persons = personsArray
    personZodiacs = personsArray
    
    
    if personZodiacs.count % 2 != 0 {
      let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
      let p = Person.init(entity: entityDescription!, insertInto: nil)
      p.zodiac = 12
      p.name = ""
      personZodiacs.append(p)
    }
    
    
    matchResultsInteger = pair(personZodiacs)
    var matchScores = [Int]()
    for i in 0..<matchResultsInteger!.count {
      var tempScore = 0
      for j in stride(from: 0, to: matchResultsInteger![0].count - 1, by: 2) {
        let person1Zodiac = matchResultsInteger![i][j].zodiacSign
        let person2Zodiac = matchResultsInteger![i][j + 1].zodiacSign
        tempScore += Zodiac.match(person1Zodiac, with: person2Zodiac)
      }
      matchScores.append(tempScore)
    }
    let bestResultIndex = matchScores.firstIndex(of: matchScores.max()!)!
    let pairing = matchResultsInteger![bestResultIndex]
    var pairingPersons = [Person]()
    for i in 0..<pairing.count {
      for person in personZodiacs {
        if person == pairing[i] {
          pairingPersons.append(person)
        }
      }
    }
    
    
    
    
    for i in stride(from: 0, to: pairingPersons.count - 1, by: 2) {
      if pairingPersons[i].zodiacSign == .alone {
        loner = pairingPersons[i + 1]
      } else if pairingPersons[i + 1].zodiacSign == .alone {
        loner = pairingPersons[i]
      } else {
        let person1Zodiac = pairingPersons[i].zodiacSign
        let person2Zodiac = pairingPersons[i + 1].zodiacSign
        switch Zodiac.match(person1Zodiac, with: person2Zodiac) {
        case 6:
          perfectMatches.append([pairingPersons[i], pairingPersons[i + 1]])
        case 5:
          complimentary.append([pairingPersons[i], pairingPersons[i + 1]])
        case 4:
          gmoe.append([pairingPersons[i], pairingPersons[i + 1]])
        case 3:
          goodFriend.append([pairingPersons[i], pairingPersons[i + 1]])
        case 2:
          average.append([pairingPersons[i], pairingPersons[i + 1]])
        case 1:
          poor.append([pairingPersons[i], pairingPersons[i + 1]])
        default:
          break
        }
      }
    }
    matches = perfectMatches + complimentary + goodFriend + gmoe + average + poor
  }
  
  
  func pair(_ arr: [Person]) -> [[Person]] {
    var bigA = [[Person]]()
    if arr.count == 2 {
      return [arr]
    }
    
    var firstTwo = Array(arr[arr.startIndex...arr.startIndex + 1])
    var rest = Array(arr[arr.startIndex + 2..<arr.endIndex])
    var list:[[Person]]
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
  
  
}
