//
//  ZodiacTableViewDataSource.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-20.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import NotificationCenter
import UIKit

final class ZodiacTableViewDataSource: NSObject, UITableViewDataSource {

    var dataManager: PersonDataManaging!
    weak var parentController: PersonDataUpdating?

    override init() {
        super.init()
        addObservers()
    }

    var sort: PersonSort = .createdOn {
        didSet {
            dataManager.sort = sort
        }
    }

    var numberOfRows: Int {
        dataManager.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
            as! PersonCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }

    func configureCell(cell: PersonCell, indexPath: IndexPath) {
        let person = dataManager.fetch(at: indexPath)
        cell.selectionStyle = .none
        cell.configureCell(person: person)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func person(at item: Int) -> Person {
        dataManager.fetch(at: IndexPath(row: item, section: 0))
    }

    func deletePerson(at row: Int) {
        let personToDelete = person(at: row)
        dataManager.delete(personToDelete)
    }

    func deletePerson(at indexPath: IndexPath) {
        deletePerson(at: indexPath.row)
    }

    func tableView(
        _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            deletePerson(at: indexPath)
        }
    }

    func addObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(didChangePerson), name: .CZPersonDidChange, object: nil)
    }

    @objc func didChangePerson(note: Notification) {
        guard let userInfo = note.userInfo else {
            return
        }

        if let action = userInfo["action"] as? String,
            action == "delete",
            let indexPathAffected = userInfo["indexPath"] as? IndexPath
        {
            parentController?.delete(at: indexPathAffected)
        } else if let action = userInfo["action"] as? String,
            action == "insert",
            let indexPathAffected = userInfo["indexPath"] as? IndexPath
        {
            parentController?.insert(at: indexPathAffected)
        }
    }
}
