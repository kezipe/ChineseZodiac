//
//  MatchResultVCDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-25.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class MatchResultVCDataSource: NSObject, UITableViewDataSource {
  fileprivate var matchResults = [Match]()
  fileprivate var persons = [Person]()
  weak var parentController: DataRefreshing?
  fileprivate var matchWorkItem: DispatchWorkItem?
  
  func matchUp() {
    guard matchWorkItem == nil || matchWorkItem!.isCancelled else {
      return
    }
    
    matchWorkItem = DispatchWorkItem {
        let match = Matcher(personsArray: self.persons)
        self.matchResults = match.matchUp().sorted()
        self.parentController?.refresh()
    }
    
    DispatchQueue.global(qos: .userInitiated).async(execute: matchWorkItem!)
  }
  
  func stopMatchUp() {
    matchWorkItem?.cancel()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let match = matchResults[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MatchResultCell") as! MatchResultCell
    cell.configureCell(match: match)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return matchResults.count
  }
}

extension MatchResultVCDataSource: PersonsReceivable {
  func receive(persons: [Person]) {
    self.persons = persons
  }
}
