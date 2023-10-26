//
//  ContentViewModel.swift
//  CoreDataStudy
//
//  Created by 현수빈 on 10/26/23.
//

import Foundation
import MightyCombine
import Combine

class ContentViewModel: ObservableObject {
    
    private let repository: ItemRepositoriable
    private let session: URLSessionable
    private var store = Set<AnyCancellable>()
    
    init(repository: ItemRepositoriable = MemoRepository(),
         session: URLSessionable = URLSession.shared) {
        self.repository = repository
        self.session = session
    }
    
    func onAppear_add() {
        
        // 생성
        let new = MemoEntity(id: 3, context: "hi2", date: Date(), title: "title")
        print(new)
        repository.create(new)
        
//        // 수정
//        let edited = new.with(\.title, "new title")
//        repository.edit(edited)
        
        // 가져오기
        let items = repository.getAllItems()
        dump(items)
        
    }
    
    
    func onAppear_fetchAPI(username: String) {
        EndPoint
            .init("https://api.github.com")
            .urlPaths(["/users", "/\(username)"])
            .urlSession(self.session)
            .requestPublisher(expect: UserResponse.self)
            .sink(receiveCompletion: { _  in}, receiveValue: { item in
                let new = MemoEntity(id: 5, context: "\(item.id)", date: Date(), title: item.login)
                print(new)
                self.repository.create(new)
            }).store(in: &store)
    }
    
    func onAppear_fetchAPI_async(username: String) async throws -> Memo? {
        guard var old = repository.getAllItems().first else {return nil}
        
        let new = try await EndPoint
            .init("https://api.github.com")
            .urlPaths(["/users", "/\(username)"])
            .urlSession(self.session)
            .requestPublisher(expect: UserResponse.self)
            .asyncThrows
        // 일부로 entity가 아닌 직접 객체를 이용해서 접근함 문제 안생김!!
        var newMemo = Memo(context: CoreDataDB.shared.context)
        newMemo.id = 44
        newMemo.title = new.login
        return newMemo
    }
    
    func getAllMemos() -> [MemoEntity] {
        repository.getAllItems()
    }
}


struct UserResponse: Codable {
    
    let id: Int
    let login: String
}
