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
    
    var body: some View {
        
          NavigationStack {
              List(viewModel.memoList) { item in
                HStack {
                    Text(item.title)
                        .bold()
                    Text("id: \(item.id)")
                        .fontWeight(.thin)
                    Spacer()
                    Button {
                        viewModel.deleteItem(item: item)
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
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
            .sheet(isPresented: $showModal, content: {
                AddMemoView(viewModel: viewModel, showModal: $showModal)
            })
        }
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
    MemoView(viewModel: ContentViewModel(), showModal: false)
}
