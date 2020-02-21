//
//  TableView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit


class ZodiacTableView: UIViewController {
  
  
  private lazy var delegate = ZodiacTableViewDelegate()
  private lazy var dataSource = ZodiacTableViewDataSource()
  
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
    if segue.identifier == "showDetailsVC" {
      if let destination = segue.destination as? DetailsVC {
        if let row = sender as? Int {
          let person = dataSource.person(at: row)
          destination.person = person
        }
      }
    }
  }
  
}


extension ZodiacTableView: PersonPresenting {
  func didSelectPerson(at row: Int) {
    performSegue(withIdentifier: "showDetailsVC", sender: row)
  }
}

extension ZodiacTableView: PersonDeleting {
  func deletePerson(at row: Int) {
    dataSource.deletePerson(at: row)
    tableView.reloadData()
  }
}


