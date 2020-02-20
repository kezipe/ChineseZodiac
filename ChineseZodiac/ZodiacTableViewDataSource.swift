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
  
  var persons = [Person]()
  var controller: NSFetchedResultsController<Person>!
  
  func retrieveData() {
//    let sortBy = PersonSort(rawValue: segmentedControl.selectedSegmentIndex)
    let sortBy = PersonSort(rawValue: 0)
    controller = PersonDao.retrieveData(sortBy: sortBy!)
    persons = controller.fetchedObjects!
  }
  
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
  
  // iOS 11+
  @available(iOS 11.0, *)
  func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
    
    let person = self.persons[indexPath.row]
    
    let action = UIContextualAction(style: .destructive, title: " ") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
      context.delete(person)
      ad.saveContext()
      
      do {
        self.persons = try context.fetch(Person.fetchRequest())
      } catch {
        print("Fetching Failed")
      }
      self.retrieveData()
//      self.tableView.reloadData()
    }
    action.image = #imageLiteral(resourceName: "xSymbolW")
    action.backgroundColor = Helper.colorGreen
    return action
  }
}


extension ZodiacTableViewDataSource: NSFetchedResultsControllerDelegate {
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                  didChange anObject: Any,
                  at indexPath: IndexPath?,
                  for type: NSFetchedResultsChangeType,
                  newIndexPath: IndexPath?) {
    
    switch type {
    case.insert:
      if let indexPath = newIndexPath {
//        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break
    case.delete:
      if let indexPath = indexPath {
//        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      break
    case.update:
      if let indexPath = indexPath {
//        let cell = tableView.cellForRow(at: indexPath) as! PersonCell
//        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
      }
    case.move:
      if let indexPath = indexPath {
//        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      if let indexPath = newIndexPath {
//        tableView.insertRows(at: [indexPath], with: .fade)
      }
      break
    @unknown default:
      fatalError()
    }
    
  }
}
