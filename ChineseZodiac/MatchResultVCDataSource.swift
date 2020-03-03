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
  fileprivate var matcher: Matcher?
  weak var parentController: DataRefreshing?
  
  func matchUp() {
    DispatchQueue.global(qos: .background).async {
      self.matcher = Matcher(personsArray: self.persons)
      if let matches = self.matcher?.findBestMatches() {
        self.matchResults = matches.sorted()
      }
      self.parentController?.refresh()
    }
  }
  
  func stopMatchUp() {
    matcher?.stopMatchUp()
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
