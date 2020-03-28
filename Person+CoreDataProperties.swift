//
//  Person+CoreDataProperties.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-03-27.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var birthdate: Date
    @NSManaged public var created: Date
    @NSManaged public var name: String
    @NSManaged public var zodiac: Int16

}
