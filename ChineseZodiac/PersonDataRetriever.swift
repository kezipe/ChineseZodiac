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



final class PersonDataRetriever {
  
  static let shared = PersonDataRetriever()
  let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
  var controller: NSFetchedResultsController<Person>!
  
  private init() {
    setSortingMethod()
    controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                               managedObjectContext: context,
                               sectionNameKeyPath: nil,
                               cacheName: nil)
  }
  
  func setSortingMethod(sortBy sortMethod: PersonSort = .createdOn) {
    fetchRequest.sortDescriptors = getSortDescriptors(for: sortMethod)
  }
  
  func getSortDescriptors(for sortType: PersonSort) -> [NSSortDescriptor] {
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
  
  func retrieveData(sortBy sortMethod: PersonSort) -> [Person]? {
    setSortingMethod(sortBy: sortMethod)
    attempFetch(controller)
    
    return controller.fetchedObjects
  }
  
  fileprivate func attempFetch(_ controller: NSFetchedResultsController<Person>) {
    do {
      try controller.performFetch()
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  func save(_ person: Person) {
    
  }
}
