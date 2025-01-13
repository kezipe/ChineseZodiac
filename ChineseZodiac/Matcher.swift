//
//  Match.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import CoreData
import Foundation

enum MatchError: Error {
    case matchDiscontinued
}

class Matcher {
    var personsArray: [Person]
    var shouldMatchContinue = false

    fileprivate func insertDummyPerson() {
        let newPerson = Person(context: PersistentController.shared.context)
        newPerson.zodiac = 13
        newPerson.name = ""
        personsArray.append(newPerson)
    }

    init(personsArray: [Person]) {
        self.personsArray = personsArray

        if personsArray.count % 2 != 0 {
            insertDummyPerson()
        }
    }

    func stopMatchUp() {
        shouldMatchContinue = false
    }

    func removeDummyPerson() {
        let dummyPerson = personsArray.first {
            $0.zodiac == 13
        }
        if let dummyPerson = dummyPerson {
            let context = PersistentController.shared.context
            context.delete(dummyPerson)
        }
    }

    func findBestMatches() -> [Match] {
        shouldMatchContinue = true
        do {
            let pairedPersons = try pair(personsArray)
            let bestScenario = try findBestScenario(pairedPersons)
            return bestScenario
        } catch MatchError.matchDiscontinued {
            print("Match cancelled")
            return []
        } catch {
            fatalError("Unknown error: \(error.localizedDescription)")
        }
    }

    fileprivate func pair(_ arr: [Person]) throws -> [[Person]] {
        guard shouldMatchContinue else {
            throw MatchError.matchDiscontinued
        }
        var bigA = [[Person]]()
        if arr.count == 2 {
            return [arr]
        }

        var firstTwo = Array(arr[...(arr.startIndex + 1)])
        var rest = Array(arr[(arr.startIndex + 2)...])
        var list: [[Person]]
        for i in 0...rest.count {

            list = try pair(rest)

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

    fileprivate func findBestScenario(_ pairedPersons: [[Person]]) throws -> [Match] {
        var bestMatchScore = 0
        var bestMatch = [Match]()

        for i in 0..<pairedPersons.count {
            var tempScore = 0
            var tempMatch = [Match]()

            for j in stride(from: 0, to: pairedPersons[0].count - 1, by: 2) {
                guard shouldMatchContinue else {
                    throw MatchError.matchDiscontinued
                }
                let person1 = pairedPersons[i][j]
                let person2 = pairedPersons[i][j + 1]

                let person1Zodiac = person1.zodiacSign
                let person2Zodiac = person2.zodiacSign
                let matchScore = Zodiac.match(person1Zodiac, with: person2Zodiac)
                let compatibility = Compatibility(rawValue: matchScore)!
                let match = Match(
                    firstPerson: person1, secondPerson: person2, compatibility: compatibility)

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
