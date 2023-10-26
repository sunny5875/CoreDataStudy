//
//  MemoEntity.swift
//  CoreDataStudy
//
//  Created by 현수빈 on 10/26/23.
//

import Foundation

struct MemoEntity: SelfReturnable, Identifiable {
    var id: Int16
    var context: String
    var date: Date
    var title: String
}

//
//struct UserEntity {
//    var name: String
//    var id: Int32
//}
