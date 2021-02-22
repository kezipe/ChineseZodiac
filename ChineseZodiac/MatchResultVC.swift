//
//  MatchResultVC.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-07-16.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit

final class MatchResultVC: UIViewController {
  
  fileprivate var dataSource: (MatchResultVCDataSource & PersonsReceivable) = MatchResultVCDataSource()
  fileprivate var customView = MatchResultView()
  
  override func loadView() {
    view = customView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource.parentController = self
    customView.setDataSource(dataSource)
    title = "Match Results"
  }
  
  override func viewDidAppear(_ animated: Bool) {
    dataSource.matchUp()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    dataSource.stopMatchUp()
    dataSource.removeDummyPerson()
  }
}

extension MatchResultVC: PersonsReceivable {
  func receive(persons: [Person]) {
    dataSource.receive(persons: persons)
  }
}

extension MatchResultVC: DataRefreshing {
  func refresh() {
    DispatchQueue.main.async {
      self.customView.reloadData()
    }
  }
}
