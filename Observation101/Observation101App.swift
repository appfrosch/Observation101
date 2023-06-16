//
//  Observation101App.swift
//  Observation101
//
//  Created by Andreas Seeger on 16.06.23.
//

import SwiftUI

@main
struct Observation101App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//MARK: View Layer
struct ContentView: View {
    @State private var itemsViewModel = ItemsViewModel(
        items: [
            Item(title: "First item"),
            Item(title: "Second item"),
        ]
    )
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($itemsViewModel.items) { $item in
                    NavigationLink {
                        ItemDetailView(item: item)
                    } label: {
                        Text(item.title)
                    }
                }
            }
        }
    }
}

#Preview("ContentView") {
    ContentView()
}

struct ItemDetailView: View {
    @Bindable var item: Item // trying the new `@Bindable` annotation leads to the error `'init(wrappedValue:)' is unavailable: The wrapped value must be an object that conforms to Observable`
    
    var body: some View {
        Form {
            Text(item.title)
        }
    }
}

#Preview("ItemDetailView") {
    ItemDetailView(item: Item())
}

//MARK: ViewModel Layer
import Observation //required to use the new, well, observation stuff

@Observable final class ItemsViewModel {
    var items: [Item] = .init() //not providing a default value here (despite having an initialiser!) results in the error message `@Observable requires property 'items' to have an initial value (from macro 'Observable')`
    
    init(
        items: [Item] = .init()
    ) {
        self.items = items
    }
}

//MARK: Model Layer
struct Item: Identifiable {
    let id: UUID
    var title: String
    
    init(
        id: UUID = .init(),
        title: String = "New Item"
    ) {
        self.id = id
        self.title = title
    }
}
