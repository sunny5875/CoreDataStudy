//
//  AddUserView.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/31/23.
//

import SwiftUI

struct AddUserView: View {
    
    @StateObject var viewModel: ContentViewModel
    @Binding var showModal: Bool
    
    @State private var multiSelection = Set<MemoEntity>()
    
    var body: some View {
        NavigationView {
            Form {
                TextField(
                        "UserName",
                        text: $viewModel.newUser.name
                    )
                
                TextField(
                        "UserName",
                        text: $viewModel.newUser.nickname
                    )
                
                
                Button("Save") {
                    viewModel.addItem()
                    viewModel.newItem = MemoEntity.dummy()
                    viewModel.addUser()
                    viewModel.newUser = UserEntity.dummy()
                    showModal.toggle()
                }
                Button("Cancel") {
                    showModal.toggle()
                }
            }
            
        }
        .navigationBarTitle(Text("Add User"))
    }
}
#Preview {
    AddMemoView(viewModel: ContentViewModel(), showModal: .constant(true))
}
