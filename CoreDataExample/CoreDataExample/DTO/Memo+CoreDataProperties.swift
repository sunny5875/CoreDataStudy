//
//  Memo+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/26/23.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }
 // @NSManaged: 해당 property가 동적으로 정의될 수 있음을 컴파일러에게 알리는 역할
    @NSManaged public var title: String?
    @NSManaged public var context: String?
    @NSManaged public var id: Int16
    @NSManaged public var date: Date?

}

extension Memo : Identifiable {

}
