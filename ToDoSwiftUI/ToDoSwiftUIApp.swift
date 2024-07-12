//
//  ToDoSwiftUIApp.swift
//  ToDoSwiftUI
//
//  Created by Khavishini on 12/07/2024.
//

import SwiftUI

@main
struct ToDoSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
