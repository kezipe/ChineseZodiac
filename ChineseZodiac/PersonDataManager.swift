//
//  PersonDao.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2019-10-26.
//  Copyright © 2019 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData

enum PersonSort: Int {
  case createdOn
  case name
  case zodiac
  case birthday
}



final class PersonDataManager {
  
  static let shared = PersonDataManager()
  fileprivate let fetchRequest: NSFetchRequest<Person> = Person.createFetchRequest()
  fileprivate var controller: NSFetchedResultsController<Person>!
  weak var delegate: NSFetchedResultsControllerDelegate! {
    didSet {
      controller.delegate = delegate
    }
  }
  
  var sort: PersonSort = .createdOn {
    didSet {
      fetchRequest.sortDescriptors = getSortDescriptors(for: sort)
      attempFetch()
    }
  }
  
  var numberOfObjects: Int {
    controller.sections![0].numberOfObjects
  }
  
  var allPeople: [Person] {
    controller.sections![0].objects! as! [Person]
  }
  
  init() {
    fetchRequest.sortDescriptors = getSortDescriptors(for: sort)
    controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                               managedObjectContext: context,
                               sectionNameKeyPath: nil,
                               cacheName: nil)
    attempFetch()
    
    #if DEBUG
    deleteAllData()
    insertTestData()
    #endif
  }
  
  fileprivate func getSortDescriptors(for sortType: PersonSort) -> [NSSortDescriptor] {
    switch sortType {
    case .createdOn:
      return [NSSortDescriptor(key: "created", ascending: false)]
    case .name:
      return [NSSortDescriptor(key: "name", ascending: true)]
    case .zodiac:
      return [NSSortDescriptor(key: "zodiac", ascending: true)]
    case .birthday:
      return [NSSortDescriptor(key: "birthdate", ascending: false)]
    }
  }
  
  fileprivate func attempFetch() {
    do {
      try controller.performFetch()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  #if DEBUG
  fileprivate func insertTestData() {
    let names = ["Alice", "Bob", "Chris", "Doug", "Erin", "Frank"]
    let birthdays = [
      "2000-06-22",
      "1998-06-22",
      "1990-06-22",
      "2001-06-22",
      "1995-06-22",
      "2020-06-22"
    ]
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    for i in (0 ..< names.count).reversed() {
      let birthday = dateFormatter.date(from: birthdays[i])!
      create(name: names[i], birthday: birthday)
    }
  }
  
  fileprivate func deleteAllData() {
    for p in allPeople {
      delete(p)
    }
  }
  #endif

}

extension PersonDataManager: PersonDataManaging {
  func create(name: String, birthday: Date) {
    let person = Person(context: context)
    person.created = Date()
    person.birthdate = birthday
    person.name = name
    person.zodiac = Int16(birthday.getZodiacRank())
    ad.saveContext()
    attempFetch()
  }
  
  func delete(_ person: Person) {
    context.delete(person)
    ad.saveContext()
    attempFetch()
  }
  
  func fetch(at indexPath: IndexPath) -> Person {
    controller.object(at: indexPath)
  }
}
