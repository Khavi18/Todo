//
//  ContentView.swift
//  ToDoSwiftUI
//
//  Created by Khavishini on 12/07/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingAddToDoView: Bool = false

    var body: some View {
        NavigationView {
            List(0 ..< 5) { item in
                Text("Hello world")
                
            }//: List
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button(action: {
                    //Show
                    self.showingAddToDoView.toggle()
                }, label: {
                    Image(systemName: "plus")
                })//: Add button
                .sheet(isPresented: $showingAddToDoView, content: {
                    AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
                })
            })
            
        }//: NavigationView
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
