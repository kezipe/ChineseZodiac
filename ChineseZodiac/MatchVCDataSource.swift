//
//  MatchVCDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class MatchVCDataSource: NSObject, UICollectionViewDataSource {
  
  weak var parentController: PersonColCellDelegate?

  private var persons = [Person]()
  private let CELL_IDENTIFIER = "PersonColCell"
  
  func fillData(_ persons: [Person]) {
    self.persons.append(contentsOf: persons)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return persons.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER,
                                                  for: indexPath) as? PersonColCell else {
      fatalError("Cannot dequeue or cast UITableView as \"PersonColCell\"")
    }
    
    cell.configureCell(person: persons[indexPath.row])
    cell.delegate = parentController
    return cell
  }
}
