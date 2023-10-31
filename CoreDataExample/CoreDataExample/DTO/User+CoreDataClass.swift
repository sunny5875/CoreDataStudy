//
//  User+CoreDataClass.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/31/23.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    var toEntity: UserEntity {
        return .init(name: self.name, nickname: self.nickname, isGirl: self.isGirl)
    }
}
