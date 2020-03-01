//
//  ZodiacTableViewDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-20.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit
import CoreData



final class ZodiacTableViewDataSource: NSObject, UITableViewDataSource {
  
  private var persons = [Person]()
  
  var numberOfRows: Int {
    persons.count
  }
  
  #if DEBUG
  func reInsertTestPerson() {
    for (index, person) in persons.enumerated().reversed() {
      context.delete(person)
      persons.remove(at: index)
    }
    for year in 2020 ..< 2032 {
      let person = Person(context: context)
      let birthday = Date(fromYear: year, month: 6, day: 22)
      person.birthdate = birthday
      person.zodiac = Int16(birthday.getZodiacRank())
      person.name = "\(person.zodiacName)"
      persons.append(person)
    }
    ad.saveContext()
  }
  
  func insertRandomTestPersons(count: Int) {
    for _ in 0 ..< count {
      let person = Person(context: context)
      let randomRange: ClosedRange<Double> = 0...Date().timeIntervalSince1970
      person.birthdate = Date(timeIntervalSince1970: Double.random(in: randomRange))
      person.name = "Test Person \(Int.random(in: 0...1000))"
      person.zodiac = Int16(person.birthdate!.getZodiacRank())
      persons.append(person)
    }
    ad.saveContext()
  }
  #endif
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
    configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
    return cell
  }
  
  func configureCell(cell: PersonCell, indexPath: NSIndexPath) {
    let person = persons[indexPath.row]
    cell.configureCell(person: person)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfRows
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func retrieveData(sortBy: PersonSort = .createdOn) {
    guard let fetchedPersons = PersonDataRetriever.shared.retrieveData(sortBy: sortBy) else {
      fatalError("Unable to fetch persons")
    }
    persons = fetchedPersons
  }
  
  func person(at item: Int) -> Person {
    return persons[item]
  }
  
  func deletePerson(at row: Int) {
    let personToDelete = person(at: row)
    context.delete(personToDelete)
    ad.saveContext()
    retrieveData()
  }

}



