//
//  AppDelegate.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var dataManager: PersonDataManaging?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    dataManager = PersonDataManager.shared
    return true
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    self.saveContext()
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ChineseZodiac")
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  // MARK: - Core Data Saving support
  
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

let ad = UIApplication.shared.delegate as! AppDelegate
let context = ad.persistentContainer.viewContext


