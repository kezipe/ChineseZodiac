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
    tableView.dataSource = dataSource
    
    #if DEBUG
    dataSource.insertTestPerson(suffix: 0)
    dataSource.insertTestPerson(suffix: 1)
    dataSource.insertTestPerson(suffix: 2)
    #endif
  }
  
  override func viewWillAppear(_ animated: Bool) {
    refreshData()
  }
  
  func refreshData() {
    let sortBy = PersonSort(rawValue: segmentedControl.selectedSegmentIndex)!
    dataSource.retrieveData(sortBy: sortBy)
    tableView.reloadData()
  }
  
  @IBAction func segmentChange(_ sender: Any) {
    refreshData()
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
    tableView.reloadData()
  }
}


