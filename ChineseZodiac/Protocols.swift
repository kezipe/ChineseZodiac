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
  func savePerson(_ person: Person)
}

protocol DatePickable: class {
  func didTapRow(at row: Int)
}
