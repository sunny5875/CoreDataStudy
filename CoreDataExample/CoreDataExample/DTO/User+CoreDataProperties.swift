//
//  User+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/31/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var relationship: Memo?
    @NSManaged public var nickname: String
    @NSManaged public var isGirl: Bool

}

extension User : Identifiable {

}
