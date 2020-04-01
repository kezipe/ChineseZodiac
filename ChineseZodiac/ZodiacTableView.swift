//
//  TableView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit


final class ZodiacTableView: UIViewController {
  
  
  private lazy var delegate = ZodiacTableViewDelegate()
  private lazy var dataSource = ZodiacTableViewDataSource()
  private let DETAILS_SEGUE_IDENTIFIER = "showDetailsVC"
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = delegate
    delegate.parentController = self
    
    let nib = UINib.init(nibName: "PersonCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "PersonCell")
    let dataManager = PersonDataManager.shared
    dataManager.delegate = dataSource
    dataSource.dataManager = dataManager
    dataSource.parentController = self
    tableView.dataSource = dataSource
  }
  
  @IBAction func segmentChange(_ sender: Any) {
    let sortBy = PersonSort(rawValue: segmentedControl.selectedSegmentIndex)!
    dataSource.sort = sortBy
    tableView.reloadData()
  }
  
  // MARK: Prepare for segue and Popover
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard checkSegueIdentifier(segue: segue) else {
      return
    }
    guard let destination = segue.destination as? DetailsVC else {
      return
    }
    
    guard let row = sender as? Int else {
      return
    }
    
    let person = dataSource.person(at: row)
    destination.person = person

  }
  
  fileprivate func checkSegueIdentifier(segue: UIStoryboardSegue) -> Bool {
    return segue.identifier == DETAILS_SEGUE_IDENTIFIER
  }
  
}

// MARK: Person Present
extension ZodiacTableView: PersonPresenting {
  func didSelectPerson(at row: Int) {
    performSegue(withIdentifier: DETAILS_SEGUE_IDENTIFIER, sender: row)
  }
}

// MARK: Person Delete
extension ZodiacTableView: PersonDeleting {
  func deletePerson(at row: Int) {
    dataSource.deletePerson(at: row)
  }
}


extension ZodiacTableView: PersonDataUpdating {
  func delete(at indexPath: IndexPath) {
    tableView.beginUpdates()
    tableView.deleteRows(at: [indexPath], with: .automatic)
    tableView.endUpdates()
  }
  
  func insert(at indexPath: IndexPath) {
    tableView.beginUpdates()
    tableView.insertRows(at: [indexPath], with: .automatic)
    tableView.endUpdates()
  }
  
  
}
