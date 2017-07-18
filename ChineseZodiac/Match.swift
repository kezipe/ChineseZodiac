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
    
    init(persons: [Person]) {
        self.persons = persons
        personZodiacs = [Person]()
        
        for p in self.persons! {
            personZodiacs.append(p)
        }
        
        if personZodiacs.count % 2 != 0 {
            print(personZodiacs.count % 2)
            let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
            let p = Person.init(entity: entityDescription!, insertInto: nil)
            p.zodiac = 13
            p.name = ":("
            personZodiacs.append(p)
        }
        
        
        matchResultsInteger = pair(personZodiacs)
        var matchScores = [Int]()
        for i in 0..<matchResultsInteger!.count {
            var tempScore = 0
            for j in stride(from: 0, to: matchResultsInteger![0].count - 1, by: 2) {
                tempScore += Helper.match(person1: Int(matchResultsInteger![i][j].zodiac), person2: Int(matchResultsInteger![i][j + 1].zodiac))
            }
            matchScores.append(tempScore)
        }
        let bestResultIndex = matchScores.index(of: matchScores.max()!)!
        let pairing = matchResultsInteger![bestResultIndex]
        var pairingPersons = [Person]()
        for i in 0..<pairing.count {
            for person in personZodiacs {
                if person == pairing[i] {
                    pairingPersons.append(person)
                }
            }
        }
        
        var pairings = [[Person]]()
        for i in stride(from: 0, to: pairingPersons.count - 1, by: 2) {
            print("Person has \(pairingPersons[i].zodiac)")
            print("Person has \(pairingPersons[i + 1].zodiac)")
            if pairingPersons[i].zodiac == 13 {
                loner = pairingPersons[i + 1]
            } else if pairingPersons[i + 1].zodiac == 13 {
                loner = pairingPersons[i]
            } else {
                pairings.append([pairingPersons[i], pairingPersons[i + 1]])
            }
        }
        
        matches = pairings
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
