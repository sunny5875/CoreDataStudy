//
//  CoreDataExampleApp.swift
//  CoreDataExample
//
//  Created by 현수빈 on 10/26/23.
//

import SwiftUI

@main
struct CoreDataExampleApp: App {
    var body: some Scene {
        WindowGroup {
            MemoView(viewModel: ContentViewModel(), showModal: false)
        }
    }
}
