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



final class PersonDataManager: NSObject {
  
  static let shared = PersonDataManager()
  fileprivate let fetchRequest: NSFetchRequest<Person> = Person.createFetchRequest()
  fileprivate var controller: NSFetchedResultsController<Person>!
  
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
  
  fileprivate override init() {
    super.init()
    fetchRequest.sortDescriptors = getSortDescriptors(for: sort)
    controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                               managedObjectContext: context,
                               sectionNameKeyPath: nil,
                               cacheName: nil)
    attempFetch()
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
