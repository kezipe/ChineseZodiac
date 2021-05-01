//
//  PersonDao.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2019-10-26.
//  Copyright © 2019 Monorail Apps. All rights reserved.
//

import CoreData
import Foundation
import Zodiacs

enum PersonSort: Int {
  case name
  case zodiac
  case birthday
  case createdOn
}



final class PersonDataManager: NSObject {
  
  fileprivate let isSubsequentLaunch = "isSubsequentLaunch"
  static let shared = PersonDataManager()
  fileprivate let fetchRequest: NSFetchRequest<Person> = Person.createFetchRequest()
  fileprivate var controller: NSFetchedResultsController<Person>!
  
  var sort: PersonSort = .createdOn {
    didSet {
      fetchRequest.sortDescriptors = getSortDescriptors(for: sort)
      zodiacSortCache.removeAll(keepingCapacity: true)
      attempFetch()
    }
  }

  private var zodiacSortCache: [Person] = []
  
  var numberOfObjects: Int {
    controller.sections![0].numberOfObjects
  }
  
  var allPeople: [Person] {
    controller.sections![0].objects! as! [Person]
  }
  
  override init() {
    super.init()
    fetchRequest.sortDescriptors = getSortDescriptors(for: sort)
    controller = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: PersistentController.shared.context,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    controller.delegate = self
    attempFetch()
    
    #if DEBUG
    deleteAllData()
    insertSampleData()
    #else
    if isFirstRun == false {
      insertSampleData()
      saveFirstRun()
    }
    #endif
  }
  
  fileprivate var isFirstRun: Bool {
    let defaults = UserDefaults.standard
    return defaults.bool(forKey: isSubsequentLaunch)
  }
  
  fileprivate func saveFirstRun() {
    let defaults = UserDefaults.standard
    defaults.set(true, forKey: isSubsequentLaunch)
  }
  
  fileprivate func getSortDescriptors(for sortType: PersonSort) -> [NSSortDescriptor] {
    switch sortType {
    case .createdOn, .zodiac:
      return [NSSortDescriptor(key: "created", ascending: false)]
    case .name:
      return [NSSortDescriptor(key: "name", ascending: true)]
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
  
  fileprivate func insertSampleData() {
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
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = "yyyy-MM-dd"
    for i in (0 ..< names.count).reversed() {
      let birthday = dateFormatter.date(from: birthdays[i])!
      create(name: names[i], birthday: birthday)
    }
  }
  
  #if DEBUG
  fileprivate func deleteAllData() {
    for p in allPeople {
      delete(p)
    }
  }
  #endif

}

extension PersonDataManager: PersonDataManaging {
  func create(name: String, birthday: Date) {
    let person = Person(context: PersistentController.shared.context)
    person.created = Date()
    person.birthdate = birthday
    person.name = name
    PersistentController.shared.saveContext()
    attempFetch()
  }
  
  func delete(_ person: Person) {
    PersistentController.shared.context.delete(person)
    PersistentController.shared.saveContext()
    attempFetch()
  }
  
  func fetch(at indexPath: IndexPath) -> Person {
    if sort == .zodiac {
      if zodiacSortCache.isEmpty {
        let allObjects = controller.fetchedObjects?.sorted {
          guard let first = $0.zodiacSign, let second = $1.zodiacSign else {
            return false
          }
          return first < second
        }
        if let sorted = allObjects {
          self.zodiacSortCache = sorted
          return sorted[indexPath.row]
        }
      } else {
        return zodiacSortCache[indexPath.row]
      }
    }
    return controller.object(at: indexPath)
  }
}

extension Notification.Name {
  static let CZPersonDidChange = Notification.Name("CZPersonDidChangeNotification")
}

extension PersonDataManager: NSFetchedResultsControllerDelegate {
  func controller(
    _ controller: NSFetchedResultsController<NSFetchRequestResult>,
    didChange anObject: Any,
    at indexPath: IndexPath?,
    for type: NSFetchedResultsChangeType,
    newIndexPath: IndexPath?
  ) {
    guard let personAffected = anObject as? Person else {
        return
    }
    var userInfo: [AnyHashable: Any] = [
      "person": personAffected
    ]
    switch type {
    case .delete:
      userInfo["action"] = "delete"
      userInfo["indexPath"] = indexPath!
    case .insert:
      userInfo["action"] = "insert"
      userInfo["indexPath"] = newIndexPath!
    default:
      return
    }
    NotificationCenter.default.post(name: .CZPersonDidChange, object: nil, userInfo: userInfo)
  }
}
