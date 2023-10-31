//
//  ContentViewModel.swift
//  CoreDataStudy
//
//  Created by 현수빈 on 10/26/23.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var newItem: MemoEntity = MemoEntity.dummy()
    @Published var memoList: [MemoEntity] = []
    @Published var newUser: UserEntity = UserEntity.dummy()
    
    private let repository: MemoRepository
    private let userRepository: UserRepository
    private var store = Set<AnyCancellable>()
    
    init(repository: MemoRepository = MemoRepository(),
         userRepository: UserRepository = UserRepository()) {
        self.repository = repository
        self.userRepository = userRepository
        self.memoList = getAllMemos()
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
    
    
    func setNewItem() {
        
    }
    func getAllMemos() -> [MemoEntity] {
       memoList = repository.getAllItems()
        return memoList
    }
    
    func deleteItem(item: MemoEntity) {
        repository.delete(item)
        memoList.removeAll(where: {$0.id == item.id })
    }
    
    func deleteMemo(indexSet: IndexSet) {
        guard let item = indexSet.compactMap({ memoList[$0] }).first else {return}
        repository.delete(item)
        memoList.removeAll(where: {$0.id == item.id })
    }
    
    func addItem() {
        repository.create(newItem)
        memoList.append(newItem)
    }
    
    func addUser() {
        userRepository.create(newUser)
    }
    
    func onAppear_createMemo_300() {
        userRepository.create(UserEntity(name: "수빈", nickname: "써니", isGirl: true))
        userRepository.create(UserEntity(name: "상우", nickname: "댕우"))
        userRepository.create(UserEntity(name: "인섭", nickname: "우디"))
        let users = userRepository.getAllItems()
        
        for i in 0...300 {
            var memo = MemoEntity(id: Int16(i), context: "\(i)st context", date: Date(), title: "\(i)st title")
            switch i % 3 {
            case 0: memo.owner = users[0]
            case 1: memo.owner = users[1]
            case 2: memo.owner = users[2]
            default:
                memo.owner = UserEntity.dummy()
            }
            repository.create(memo)
            
        }
        
        print(repository.getAllItems())
    }
    
    
}


struct UserResponse: Codable {
    
    let id: Int
    let login: String
}
