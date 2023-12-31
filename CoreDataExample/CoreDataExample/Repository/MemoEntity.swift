//
//  MemoEntity.swift
//  CoreDataStudy
//
//  Created by 현수빈 on 10/26/23.
//

import Foundation

struct MemoEntity: SelfReturnable, Identifiable, Hashable {
    static func == (lhs: MemoEntity, rhs: MemoEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    
    var id: Int16
    var context: String
    var date: Date
    var title: String
    var owner: UserEntity?
}

extension MemoEntity {
    static func dummy() -> Self {
       return MemoEntity(id: Int16(Int.random(in: 0...100)), context: "dummy context", date: Date(), title: "dummy Title")
    }
}
