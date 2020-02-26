//
//  MatchResultVCDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-25.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class MatchResultVCDataSource: NSObject, UITableViewDataSource {
  fileprivate var persons = [Person]()
  fileprivate var match: Match?
  fileprivate var loner: Person?
  weak var parentController: DataRefreshing?
  
  lazy var numberOfRows: Int = {
    return persons.count
  }()
  
  func matchUp() {
    DispatchQueue.global(qos: .background).async {
      let match = Match(personsArray: self.persons)
      self.loner = match.loner
      self.match = match
      self.parentController?.refresh()
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let match = match else {
      fatalError("No matches found")
    }
    
    if let loner = loner, isLastRow(indexPath: indexPath) {
      return createLonerCell(on: tableView, for: loner)
    } else if let pair = match.matches?[indexPath.row] {
      return createNormalCell(on: tableView, for: pair)
    } else {
      fatalError()
    }
  }
  
  fileprivate func isLastRow(indexPath: IndexPath) -> Bool {
    indexPath.row == numberOfRows / 2
  }
  
  fileprivate func createNormalCell(on tableView: UITableView, for pair: [Person]) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MatchResultCell") as! MatchResultCell
    cell.configureCell(pair: pair)
    return cell
  }
  
  fileprivate func createLonerCell(on tableView: UITableView, for loner: Person) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MatchResultLonerCell") as! MatchResultLonerCell
    cell.configureCell(person: loner)
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard match != nil else { return 0 }
    
    return calculateNumberOfRows()
  }
  
  fileprivate func calculateNumberOfRows() -> Int {
    if loner != nil {
      return numberOfRows / 2 + 1
    } else {
      return numberOfRows / 2
    }
  }
}

extension MatchResultVCDataSource: PersonsReceivable {
  func receive(persons: [Person]) {
    self.persons = persons
  }
}
