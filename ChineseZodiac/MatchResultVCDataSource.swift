//
//  MatchResultVCDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-25.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class MatchResultVCDataSource: NSObject, UITableViewDataSource {
  fileprivate var persons: [Person]?
  fileprivate var match: Match?
  fileprivate var loner: Person?
  weak var parentController: DataRefreshing?
  
  func matchUp() {
    DispatchQueue.global(qos: .background).async {
      let match = Match(personsArray: self.persons!)
      self.loner = match.loner
      self.match = match
      self.parentController?.refresh()
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let match = match else { return UITableViewCell() }
    
    if self.loner != nil && indexPath.row == persons!.count / 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MatchResultLonerCell") as! MatchResultLonerCell
      cell.configureCell(person: loner!)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MatchResultCell") as! MatchResultCell
      cell.configureCell(pair: match.matches![indexPath.row])
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard match != nil else { return 0 }
    
    if self.loner != nil {
      return persons!.count / 2 + 1
    } else {
      return persons!.count / 2
    }
  }
}

extension MatchResultVCDataSource: PersonsReceivable {
  func receive(persons: [Person]) {
    self.persons = persons
  }
}
