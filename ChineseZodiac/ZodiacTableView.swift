//
//  TableView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit


final class ZodiacTableView: UIViewController {
  // MARK: Private Types
  // MARK: API Variables
  // MARK: Private Variables
  // MARK: API Functions
  // MARK: Private Functions
  private func setupUI() {
    view.addSubview(segmentedControl)
    view.addSubview(tableView)
    let multiplier: CGFloat = 1
    if #available(iOS 11.0, *) {
      NSLayoutConstraint.activate(
        [
          segmentedControl.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
            multiplier: multiplier
          ),
          segmentedControl.leadingAnchor.constraint(
            equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
            multiplier: multiplier
          ),
          view.trailingAnchor.constraint(
            equalToSystemSpacingAfter: segmentedControl.trailingAnchor, 
            multiplier: multiplier
          ),
          tableView.topAnchor.constraint(
            equalToSystemSpacingBelow: segmentedControl.bottomAnchor,
            multiplier: multiplier
          ),
          tableView.leadingAnchor.constraint(
            equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
            multiplier: multiplier
          ),
          tableView.trailingAnchor.constraint(
            equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor,
            multiplier: multiplier
          ),
          view.safeAreaLayoutGuide.bottomAnchor.constraint(
            equalToSystemSpacingBelow: tableView.bottomAnchor, 
            multiplier: multiplier
          )
        ]
      )
    } else {
      NSLayoutConstraint.activate(
        [
          segmentedControl.topAnchor.constraint(
            equalTo: view.topAnchor, 
            constant: 8 * multiplier
          ),
          segmentedControl.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 8 * multiplier
          ),
          segmentedControl.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, 
            constant: -8 * multiplier
          ),
          tableView.topAnchor.constraint(
            equalTo: segmentedControl.bottomAnchor,
            constant: 8 * multiplier
          ),
          tableView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 8 * multiplier
          ),
          tableView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -8 * multiplier
          ),
          view.bottomAnchor.constraint(
            equalTo: tableView.bottomAnchor, 
            constant: 8 * multiplier
          )
        ]
      )
    }
    
    
  }
  // MARK: Initializers
  
  private lazy var delegate = ZodiacTableViewDelegate()
  private lazy var dataSource = ZodiacTableViewDataSource()
  private let DETAILS_SEGUE_IDENTIFIER = "showDetailsVC"
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.delegate = delegate
    tv.dataSource = dataSource
    return tv
  }()
  
  private lazy var segmentedControl: UISegmentedControl = {
    let sc = ZodiacSegmentedControl()
    sc.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
    return sc
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    enableLargeTitleForNavigationController()
    tableView.delegate = delegate
    delegate.parentController = self
    let nib = UINib.init(nibName: "PersonCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "PersonCell")
    let dataManager = PersonDataManager.shared
    dataSource.dataManager = dataManager
    dataSource.parentController = self
    tableView.dataSource = dataSource
  }
  
  @objc
  func segmentChange(_ sender: Any) {
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
