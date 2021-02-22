//
//  PersistentController.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2021-01-28.
//  Copyright © 2021 Monorail Apps. All rights reserved.
//

import CoreData
import Foundation

final class PersistentController {
  static let shared = PersistentController()

  var context: NSManagedObjectContext {
    persistentContainer.viewContext
  }

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ChineseZodiac")
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  private init() {
  }

  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
