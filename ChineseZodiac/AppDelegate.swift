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
  var dataManager: PersonDataManager?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    dataManager = PersonDataManager.shared
    window = UIWindow(frame: UIScreen.main.bounds)

    let tabBarController = UITabBarController()

    let zodiacTableViewController = MainViewController()
    let zodiacNavigation = UINavigationController(
        rootViewController: zodiacTableViewController
    )

    let matchCollectionViewController = MatchVC()
    let matchNavigation = UINavigationController(
        rootViewController: matchCollectionViewController
    )

    tabBarController.viewControllers = [zodiacNavigation, matchNavigation]
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()

    return true
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    PersistentController.shared.saveContext()
  }
}


