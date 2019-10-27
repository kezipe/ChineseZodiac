//
//  PersonDao.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2019-10-26.
//  Copyright © 2019 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData

enum PersonSort: Int {
    case createdOn
    case name
    case zodiac
    case birthday
}

class PersonDao {
    static func retrieveData(sortBy: PersonSort) -> NSFetchedResultsController<Person> {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let zodiacSort = NSSortDescriptor(key: "zodiac", ascending: true)
        let birthdateSort = NSSortDescriptor(key: "birthdate", ascending: false)
        
        switch sortBy {
        case .createdOn:
            fetchRequest.sortDescriptors = [dateSort]
        case .name:
            fetchRequest.sortDescriptors = [nameSort]
        case .zodiac:
            fetchRequest.sortDescriptors = [zodiacSort]
        case .birthday:
            fetchRequest.sortDescriptors = [birthdateSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
        return controller
    }
}
