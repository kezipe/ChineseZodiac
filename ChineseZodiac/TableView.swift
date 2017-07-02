//
//  TableView.swift
//  ChineseZodiac
//
//  Created by Kevin on 2017-05-30.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import UIKit
import CoreData

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var persons: [Person] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self


    }
    
    // MARK: Core Data
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    func getData() {
        do {
            persons = try context.fetch(Person.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    // MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PersonCell()
        let person = persons[indexPath.row]
        
        return cell.configureCell(person: person)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    // MARK: deleting
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = persons[indexPath.row]
            context.delete(person)
            ad.saveContext()
            
            do {
                persons = try context.fetch(Person.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        
        tableView.reloadData()
    }
}

