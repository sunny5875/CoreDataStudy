//
//  ContentView.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/26/23.
//

import SwiftUI

struct MemoView: View {
    
    @StateObject var viewModel: ContentViewModel
    @State var showModal: Bool
    @State var showUserModal: Bool
    
    var body: some View {
          NavigationStack {
              List {
                  ForEach(viewModel.memoList) { item in
                      HStack {
                          Text(item.title)
                              .bold()
                          Text("id: \(item.id)")
                              .fontWeight(.thin)
                      }
                  }.onDelete(perform: { indexSet in
                      viewModel.deleteMemo(indexSet: indexSet)
                  })
              }
            .navigationTitle("Past Memo")
            .toolbar {
                ToolbarItem {
                    Button {
                        showModal = true
                    } label: {
                      Image(systemName: "plus")
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showUserModal = true
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                }
            }
            .toolbar {
                EditButton()
            }
            .sheet(isPresented: $showModal, content: {
                AddMemoView(viewModel: viewModel, showModal: $showModal)
            })
            .sheet(isPresented: $showUserModal, content: {
                AddUserView(viewModel: viewModel, showModal: $showUserModal)
            })
        }
//          .onAppear {viewModel.onAppear_createMemo_100()}
//        .onAppear {viewModel.onAppear_add()} // CRUD 테스트
//        .onAppear { viewModel.onAppear_fetchAPI(username: "sunny5875") } // api 테스트
//        .onAppear { // task안에 써보기
//            Task {
//                let result = try? await viewModel.onAppear_fetchAPI_async(username: "octopus")
//                print(result?.title) // 문제 없었음!!
//            }
//        }
    }
}

#Preview {
    MemoView(viewModel: ContentViewModel(), showModal: false, showUserModal: false)
}
