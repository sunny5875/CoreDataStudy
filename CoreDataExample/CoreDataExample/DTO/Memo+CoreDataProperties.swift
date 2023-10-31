//
//  Memo+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/31/23.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var context: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var owner: User?

}

extension Memo : Identifiable {

}
