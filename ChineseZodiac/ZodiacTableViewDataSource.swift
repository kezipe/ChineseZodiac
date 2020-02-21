//
//  ZodiacTableViewDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-20.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit
import CoreData



class ZodiacTableViewDataSource: NSObject, UITableViewDataSource {
  
  private var persons = [Person]()
  var controller: NSFetchedResultsController<Person>!
  
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
    let person = controller.object(at: indexPath as IndexPath)
    cell.configureCell(person: person)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = controller.sections {
      let sectionInfo = sections[section]
      return sectionInfo.numberOfObjects
    }
    return 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    if let sections = controller.sections {
      return sections.count
    }
    return 0
  }
  
  func retrieveData(sortBy: PersonSort = .createdOn) {
    controller = PersonDao.retrieveData(sortBy: sortBy)
    persons = controller.fetchedObjects!
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



