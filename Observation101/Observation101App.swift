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
                        Form {
                            TextField("Title", text: $item.title) //beware: with Xcode 15.0 beta 1 I ran into an issue where the hw keyboard would not work in preview nor simulator–the sw keyboard in the simulator works though
                        }
                    } label: {
                        Text(item.title)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
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
