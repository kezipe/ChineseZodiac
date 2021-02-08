//
//  MatchResultView.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-03-02.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

final class MatchResultView: UIView {
  fileprivate let TABLEVIEW_ROW_HEIGHT: CGFloat = 120
  fileprivate let CELL_IDENTIFIER = "MatchResultCell"

  fileprivate var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.allowsSelection = false
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  func setupUI() {
    setupBackground()
    setupTableView()
  }
  
  fileprivate func setupBackground() {
    let background = UIView()
    if #available(iOS 13, *) {
      background.backgroundColor = .systemBackground
    } else {
      background.backgroundColor = .systemGray
    }
    background.frame = UIScreen.main.bounds
    addSubview(background)
  }
  
  fileprivate func setupTableView() {
    registerTableViewCell()
    setupTableViewBackground()
    setupTableViewRowHeight()
    setupLayoutConstraints()
  }
  
  fileprivate func registerTableViewCell() {
    tableView.register(MatchResultCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
  }
  
  fileprivate func setupTableViewBackground() {
    if #available(iOS 13, *) {
      tableView.backgroundColor = .secondarySystemBackground
    } else {
      tableView.backgroundColor = .systemGray
    }
  }
  
  fileprivate func setupTableViewRowHeight() {
    tableView.rowHeight = TABLEVIEW_ROW_HEIGHT
  }
  
  fileprivate func setupLayoutConstraints() {
    addSubview(tableView)
    tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
  }
  

  
  func setDataSource(_ dataSource: (MatchResultVCDataSource & PersonsReceivable)) {
    tableView.dataSource = dataSource
  }
  
  func reloadData() {
    tableView.reloadData()
  }
}
