//
//  MemoRepository.swift
//  CoreDataStudy
//
//  Created by 현수빈 on 10/26/23.
//

import Foundation
import CoreData


protocol ItemRepositoriable {
    
    func create(_ item: MemoEntity)
    func edit(_ item: MemoEntity)
    func getItem<T: Equatable>(_ keyPath: WritableKeyPath<MemoEntity, T>, _ value: T) -> MemoEntity?
    func getAllItems() -> [MemoEntity]
    func delete(_ item: MemoEntity)
}

final class MemoRepository {
    
    private let db = CoreDataDB.shared
    
    private func getAll() -> [Memo] {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        let result = try? db.context.fetch(request)
        return result ?? []
    }
    
    private func getItem<T: Equatable>(_ keyPath: WritableKeyPath<Memo, T>, _ value: T) -> Memo? {
        getAll().filter { $0[keyPath: keyPath] == value }.first
    }
}

extension MemoRepository: ItemRepositoriable {
    
    func create(_ item: MemoEntity) {
        let new = Memo(context: db.context) // context를 가져와서 NSManagedObject를 만든다
        new.date = item.date
        new.context = item.context
        new.title = item.title
        new.id = item.id
        db.context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // upsert를 지원하기 위함
        db.save() // NSManagedObjectContext를 저장
    }
    
    
    /*
     - Entity 지정 (FROM): 필수 - NSFetchRequest
     - 검색 조건 지정 (WHERE): 생략 가능 - NSPredicate
     - 정렬 조건 지정 (ORDER BY): 생략 가능 - NSSortDescriptor
     */
    func edit(_ item: MemoEntity) {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", item.id as CVarArg)
        let object = try? db.context.fetch(request).first
        object?.title = item.title
        object?.context = item.context
        object?.date = item.date
        object?.id = item.id
        db.save()
    }
    
    func getItem<T: Equatable>(_ keyPath: WritableKeyPath<MemoEntity, T>, _ value: T) -> MemoEntity? {
        self.getAllItems().filter { $0[keyPath: keyPath] == value }.first
    }
    
    func getAllItems() -> [MemoEntity] {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        let result = try? db.context.fetch(request).map { $0.toEntity }
        
            
        return result ?? []
    }
    
    func delete(_ item: MemoEntity) {
        let object: Memo? = self.getItem(\.id, item.id)
        guard let object else { return }
        db.context.delete(object)
        db.save()
    }
    
}
