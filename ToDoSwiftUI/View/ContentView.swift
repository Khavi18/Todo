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
    @EnvironmentObject var iconSettings: IconNames
    
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)])
    private var items: FetchedResults<Item>
    
    @State private var showingAddToDoView: Bool = false
    @State private var animatingButton: Bool = false
    @State private var showingSettingsView: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.items, id: \.self) { item in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundStyle(self.colorize(priority: item.priority ?? "Normal"))
                            Text(item.name ?? "Unknown")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(item.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundStyle(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                )
                        }//: HStack
                        .padding(.vertical, 10)
                    }//: ForEach
                    .onDelete(perform: { indexSet in
                        deleteItem(at: indexSet)
                    })
                }//: List
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            //Show
                            self.showingSettingsView.toggle()
                        }, label: {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                                .tint(themes[self.theme.themeSettings].themeColor)
                        })//: Add button
                        .sheet(isPresented: $showingSettingsView, content: {
                            SettingsView().environmentObject(self.iconSettings)
                        })
                    }//: ToolbarItem
                    
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                            .tint(themes[self.theme.themeSettings].themeColor)
                    }
                    
                })
                //MARK: - No items
                if items.count == 0 {
                    EmptyListView()
                }
                
                
            }//:ZStack
            .sheet(isPresented: $showingAddToDoView, content: {
                AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
            })
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animatingButton)
                    
                    Button(action: {
                        self.showingAddToDoView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    })//: Button
                    .tint(themes[self.theme.themeSettings].themeColor)
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                }//: ZStack
                .padding(.bottom, 15)
                .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
        }//: NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            managedObjectContext.delete(item)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
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
