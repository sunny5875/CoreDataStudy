//
//  UserRepository.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/31/23.
//

import Foundation
import CoreData

final class UserRepository {
    
    private let db = CoreDataDB.shared
    
    private func getAll() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let result = try? db.context.fetch(request)
        return result ?? []
    }
    
    private func getItem<T: Equatable>(_ keyPath: WritableKeyPath<User, T>, _ value: T) -> User? {
        getAll().filter { $0[keyPath: keyPath] == value }.first
    }
}

extension UserRepository: ItemRepositoriable {
    typealias Entity = UserEntity
    func create(_ item: UserEntity) {
        let new = User(context: db.context) // context를 가져와서 NSManagedObject를 만든다
        new.name = item.name
        new.nickname = item.nickname
        new.isGirl = item.isGirl
        db.context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // upsert를 지원하기 위함
        db.save() // NSManagedObjectContext를 저장
    }
    
    
    /*
     - Entity 지정 (FROM): 필수 - NSFetchRequest
     - 검색 조건 지정 (WHERE): 생략 가능 - NSPredicate
     - 정렬 조건 지정 (ORDER BY): 생략 가능 - NSSortDescriptor
     */
    func edit(_ item: UserEntity) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", item.name)
        let object = try? db.context.fetch(request).first
        object?.name = item.name
        object?.nickname = item.nickname
        object?.isGirl = item.isGirl
        db.save()
    }
    
    func getItem<T: Equatable>(_ keyPath: WritableKeyPath<UserEntity, T>, _ value: T) -> UserEntity? {
        self.getAllItems().filter { $0[keyPath: keyPath] == value }.first
    }
    
    func getAllItems() -> [UserEntity] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let result = try? db.context.fetch(request).map { $0.toEntity }
        
        return result ?? []
    }
    
    func delete(_ item: UserEntity) {
        let object: User? = self.getItem(\.name, item.name)
        guard let object else { return }
        db.context.delete(object)
        db.save()
    }
    
}
