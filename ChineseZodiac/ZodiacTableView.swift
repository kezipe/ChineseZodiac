//
//  TableView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit


class ZodiacTableView: UIViewController, UITableViewDelegate {
  
  
  
  private lazy var dataSource = ZodiacTableViewDataSource()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = dataSource
    dataSource.retrieveData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    dataSource.retrieveData()
    tableView.reloadData()
  }
  
  
  
  @IBAction func segmentChange(_ sender: Any) {
    dataSource.retrieveData()
    tableView.reloadData()
  }
  
  // MARK: Cell Management
  

  
//  @available(iOS 11.0, *)
//  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
//    let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
//    return swipeConfig
//  }
//  // iOS 10 or lower
//  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//    let kCellActionWidth: CGFloat = 40.0
//    let kCellHeight: CGFloat = 60
//    let whitespace = " "
//    let deleteAction = UITableViewRowAction(style: .default, title: whitespace) { (action, indexPath) in
//      let person = self.persons[indexPath.row]
//      context.delete(person)
//      ad.saveContext()
//
//      do {
//        self.persons = try context.fetch(Person.fetchRequest())
//      } catch {
//        print("Fetching Failed")
//      }
//      self.retrieveData()
//      tableView.reloadData()
//    }
//
//    // create a color from patter image and set the color as a background color of action
//    let kActionImageSize: CGFloat = 34
//    let view = UIView(frame: CGRect(x: 0, y: 0, width: kCellActionWidth, height: kCellHeight))
//    view.backgroundColor = Helper.colorGreen
//    let imageView = UIImageView(frame: CGRect(x: (kCellActionWidth - kActionImageSize) / 2,
//                                              y: (kCellHeight - kActionImageSize) / 2,
//                                              width: 34,
//                                              height: 34))
//    imageView.image = UIImage(named: "xSymbol")
//    view.addSubview(imageView)
//    let image = view.image()
//
//    deleteAction.backgroundColor = UIColor(patternImage: image)
//
//    return [deleteAction]
//  }
  
  
  
  
  // MARK: Table View Stuff
  
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    performSegue(withIdentifier: "showDetailsVC", sender: persons[indexPath.row])
//  }
//
//  func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//    let cell = tableView.cellForRow(at: indexPath)
//    cell?.layer.cornerRadius = 8.0
//  }
  
  // MARK: Prepare for segue and Popover
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetailsVC" {
      if let destination = segue.destination as? DetailsVC {
        if let person = sender as? Person {
          destination.person = person
        }
      }
    }
  }
  
}



