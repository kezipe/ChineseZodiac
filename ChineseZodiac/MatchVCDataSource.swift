//
//  MatchVCDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import UIKit

class MatchVCDataSource: NSObject, UICollectionViewDataSource {

  let MAX_MATCHING_PEOPLE = 10
  private let CELL_IDENTIFIER = "PersonColCell"
  private var selectedPersons: Set<Person> = []
  
  override init() {
    super.init()
    addObservers()
  }
  
  var dataManager: PersonDataManaging!
  var sort: PersonSort = .name {
    didSet {
      dataManager.sort = sort
    }
  }
  
  var numberOfSelectedItems: Int {
    return selectedPersons.count
  }
  
  var numberOfItems: Int {
    dataManager.numberOfObjects
  }
  
  func person(at item: Int) -> Person {
    dataManager.fetch(at: IndexPath(item: item, section: 0))
  }
  
  func isSelectionLegal() -> Bool {
    return numberOfSelectedItems <= MAX_MATCHING_PEOPLE && numberOfSelectedItems > 1
  }
  
  func canMatchAll() -> Bool {
    return numberOfSelectedItems == 0 && numberOfItems <= MAX_MATCHING_PEOPLE && numberOfItems >= 2
  }
  
  func tapPerson(at item: Int) {
    let tappedPerson = person(at: item)
    if selectedPersons.contains(tappedPerson) {
      selectedPersons.remove(tappedPerson)
    } else {
      selectedPersons.insert(tappedPerson)
    }
  }
  
  func deselectAll() {
    selectedPersons.removeAll()
  }
  
  func isPersonSelected(at item: Int) -> Bool {
    let personToQuery = person(at: item)
    return selectedPersons.contains(personToQuery)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numberOfItems
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "PersonCollectionCell",
      for: indexPath
    ) as? PersonCollectionCell else {
      fatalError("Cannot dequeue or cast UITableView as \"PersonColCell\"")
    }
    let personAtIndexPath = person(at: indexPath.item)
    let isSelected = isPersonSelected(at: indexPath.item)
    cell.configureCell(person: personAtIndexPath, isSelected: isSelected)
    return cell
  }
  
  func addObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(didChangePerson), name: .CZPersonDidChange, object: nil)
  }
  
  @objc func didChangePerson(note: Notification) {
    guard let userInfo = note.userInfo else {
      return
    }
    
    if let person = userInfo["person"] as? Person,
       let action = userInfo["action"] as? String,
       action == "delete" {
      selectedPersons.remove(person)
    }
  }
}

extension MatchVCDataSource: PersonsSendable {
  func send(to receiver: PersonsReceivable) {
    if selectedPersons.isEmpty {
      receiver.receive(persons: dataManager.allPeople)
    } else {
      let personArray = Array(selectedPersons)
      receiver.receive(persons: personArray)
    }
  }
}

