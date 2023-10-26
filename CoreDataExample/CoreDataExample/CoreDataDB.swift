//
//  CoreDataDb.swift
//  CoreDataStudy
//
//  Created by 현수빈 on 10/26/23.
//

import CoreData

/// 1. Container 생성
class CoreDataDB {
    
    static let shared = CoreDataDB()
    
    // 여기 이름은 모델 이름을 넣을 것
    private let container = NSPersistentContainer(name: "Model")
    
    // context
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {
        loadStores()
    }
    // store
    private func loadStores() {
        container.loadPersistentStores(completionHandler: { _, _ in })
    }
    
    func save() {
        do {
          try context.save()
          } catch {
          let nserror = error as NSError
          NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
          }
    }
}
