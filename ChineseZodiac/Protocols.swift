//
//  Protocols.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-20.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData

protocol PersonPresenting: class {
  func didSelectPerson(at row: Int)
}

protocol PersonDeleting: class {
  func deletePerson(at row: Int)
}


protocol PersonDataManaging {
  var sort: PersonSort { get set }
  var numberOfObjects: Int { get }
  var allPeople: [Person] { get }
  func delete(_ person: Person)
  func create(name: String, birthday: Date)
  func fetch(at indexPath: IndexPath) -> Person
}

protocol PersonDataUpdating: class {
  func delete(at indexPath: IndexPath)
  func insert(at indexPath: IndexPath)
}


protocol PersonColCellDelegate: class {
  func toggleSelectionOfButton(forCell: PersonCollectionCell)
}

protocol PersonSelecting: class {
  func toggleSelection(forPersonAt item: Int)
}

protocol PersonsReceivable: class {
  func receive(persons: [Person])
}

protocol PersonsSendable: class {
  func send(to receiver: PersonsReceivable)
}

protocol DataRefreshing: class {
  func refresh()
}
