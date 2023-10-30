//
//  MemoView.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/30/23.
//

import SwiftUI

struct AddMemoView: View {
    
    @StateObject var viewModel: ContentViewModel
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            Form {
                TextField(
                        "Title",
                        text: $viewModel.newItem.title
                    )
                
                TextField(
                        "Context",
                        text: $viewModel.newItem.context
                    )
                
                
                Button("Save") {
                    viewModel.addItem()
                    viewModel.newItem = MemoEntity.dummy()
                    showModal.toggle()
                }
            }
        }
        .navigationBarTitle(Text("Add Memo"))
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    showModal.toggle()
                }
                
            }
        }
    }
}
#Preview {
    AddMemoView(viewModel: ContentViewModel(), showModal: .constant(true))
}
