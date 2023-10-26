//
//  Memo+CoreDataClass.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/26/23.
//
//

import Foundation
import CoreData

@objc(Memo)
public class Memo: NSManagedObject {

    var toEntity: MemoEntity {
        return .init(id: self.id, context: self.context ?? "_", date: self.date ?? Date(), title: self.title  ?? "_" )
    }
    
}
