//
//  UserEntity.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/31/23.
//

import Foundation

struct UserEntity: SelfReturnable, Hashable {
    var name: String
    var nickname: String
    var isGirl: Bool = false
}
extension UserEntity {
    static func dummy() -> Self {
        return UserEntity(name: "default", nickname: "default", isGirl: true)
    }
}
