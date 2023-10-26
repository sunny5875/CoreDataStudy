//
//  ContentView.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/26/23.
//

import SwiftUI

struct ContentView2: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView: View {
    
    let viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.getAllMemos()) { item in
                Text(item.title)
            }
            .navigationTitle("Past Memo")
        }
        .onAppear {viewModel.onAppear_add()} // CRUD 테스트
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
    ContentView2()
}
