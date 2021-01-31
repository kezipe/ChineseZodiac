//
//  DetailsVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-04.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class DetailsVC: UIViewController {
  
  let person: Person
  
  init(person: Person) {
    self.person = person
    super.init(nibName: nil, bundle: nil)
  }
  
  private init() {
    fatalError()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var tableViewDataSource: DetailsVCTableViewDataSource = {
    let dataSource = DetailsVCTableViewDataSource()
    dataSource.person = person
    return dataSource
  }()
  
  private lazy var tableView: UITableView = {
    let tv: UITableView
    if #available(iOS 13, *) {
      tv = UITableView(frame: .zero, style: .insetGrouped)
    } else {
      tv = UITableView()
    }
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.dataSource = tableViewDataSource
    tv.register(
      UITableViewCell.self,
      forCellReuseIdentifier: tableViewDataSource.cellIdentifier
    )
    return tv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    updateInformation()
  }
  
  fileprivate func configureBackground() {
    if #available(iOS 13, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
  }
  
  private func setupUI() {
    configureBackground()
    view.addSubview(tableView)
    let multiplier: CGFloat = 0
    if #available(iOS 11.0, *) {
      NSLayoutConstraint.activate(
        [
          tableView.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
            multiplier: multiplier
          ),
          tableView.leadingAnchor.constraint(
            equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
            multiplier: multiplier
          ),
          view.safeAreaLayoutGuide.trailingAnchor.constraint(
            equalToSystemSpacingAfter: tableView.trailingAnchor,
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
          tableView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 8 * multiplier
          ),
          tableView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 8 * multiplier
          ),
          view.trailingAnchor.constraint(
            equalTo: tableView.trailingAnchor,
            constant: 8 * multiplier
          ),
          view.bottomAnchor.constraint(
            equalTo: tableView.bottomAnchor,
            constant: 8 * multiplier
          )
        ]
      )
    }
  }
  
  fileprivate func updateInformation() {
    guard let view = view as? DetailsView else {
      return
    }
    navigationItem.title = person.name
    view.updateInformation(forPerson: person)
  }
  
  @IBAction func deleteButtonPressed(_ sender: Any) {
    PersonDataManager.shared.delete(person)
    navigateToParentController()
  }
  
  fileprivate func navigateToParentController() {
    navigationController?.popViewController(animated: true)
  }
}
