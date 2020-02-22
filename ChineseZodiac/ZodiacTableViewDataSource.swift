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
  
  #if DEBUG
  func insertTestPerson(suffix: Int) {
    let person = Person(context: context)
    person.birthdate = Date()
    person.name = "Test Person \(suffix)"
    person.zodiac = Int16(person.birthdate!.getZodiacRank())
  }
  #endif
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTable", for: indexPath) as! PersonCell
    configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
    return cell
  }
  
  func configureCell(cell: PersonCell, indexPath: NSIndexPath) {
    let person = persons[indexPath.row]
    cell.configureCell(person: person)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return persons.count
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
  
  func person(at row: Int) -> Person {
    return persons[row]
  }
  
  func deletePerson(at row: Int) {
    let personToDelete = person(at: row)
    context.delete(personToDelete)
    ad.saveContext()
    retrieveData()
  }
  


}



