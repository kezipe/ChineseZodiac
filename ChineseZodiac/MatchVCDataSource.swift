//
//  MatchVCDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

enum MatchError: Error {
  case tooManySelected(max: Int)
}

class MatchVCDataSource: NSObject, UICollectionViewDataSource {

  private let CELL_IDENTIFIER = "PersonColCell"
  private let MAX_MATCHABLE_PERSON_LIMIT = 10
  private var persons = [Person]()
  private var selectedPersons: Set<Person> = []
  
  var numberOfItems: Int {
    return persons.count
  }
  
  func person(at item: Int) -> Person {
    return persons[item]
  }
  
  func tapPerson(at item: Int) throws {
    let tappedPerson = person(at: item)
    if selectedPersons.contains(tappedPerson) {
      selectedPersons.remove(tappedPerson)
    } else if canSelectMorePersons() {
      selectedPersons.insert(tappedPerson)      
    } else {
      throw MatchError.tooManySelected(max: MAX_MATCHABLE_PERSON_LIMIT)
    }
  }
  
  func isPersonSelected(at item: Int) -> Bool {
    let personToQuery = person(at: item)
    return selectedPersons.contains(personToQuery)
  }
  
  func canSelectMorePersons() -> Bool {
    return selectedPersons.count < MAX_MATCHABLE_PERSON_LIMIT
  }
  
  func hasValidSelection() -> Bool {
    let allowAllPersons = selectedPersons.isEmpty && numberOfItems <= MAX_MATCHABLE_PERSON_LIMIT
    let allowSelectedPersons = !selectedPersons.isEmpty
    return allowAllPersons || allowSelectedPersons
  }
  
  func fetchData() {
    if let persons = PersonDataRetriever.shared.retrieveData(sortBy: .name) {
      self.persons = persons
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return persons.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER,
                                                        for: indexPath) as? PersonCollectionCell else {
      fatalError("Cannot dequeue or cast UITableView as \"PersonColCell\"")
    }
    let personAtIndexPath = person(at: indexPath.item)
    let isSelected = isPersonSelected(at: indexPath.item)
    cell.configureCell(person: personAtIndexPath, isSelected: isSelected)
    return cell
  }
}

extension MatchVCDataSource: PersonsSendable {
  func send(to receiver: PersonsReceivable) {
    if selectedPersons.isEmpty {
      receiver.receive(persons: self.persons)
    } else {
      let personArray = Array(selectedPersons)
      receiver.receive(persons: personArray)
    }
  }
}
