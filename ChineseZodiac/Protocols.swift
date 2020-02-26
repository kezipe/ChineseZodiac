//
//  Protocols.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-20.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation

protocol PersonPresenting: class {
  func didSelectPerson(at row: Int)
}

protocol PersonDeleting: class {
  func deletePerson(at row: Int)
}

protocol PersonSaving: class {
  func savePerson()
}

protocol DatePickable: class {
  func selectRow(at row: Int, mode: DateComponentSelectionMode)
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
