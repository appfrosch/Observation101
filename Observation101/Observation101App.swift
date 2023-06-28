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
        itemViewModels: [
            ItemViewModel(item: Item(title: "First item")),
            ItemViewModel(item: Item(title: "Second item")),
        ]
    )
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(itemsViewModel.itemViewModels) { itemViewModel in
                    NavigationLink {
                        ItemDetailView(itemViewModel: itemViewModel)
                    } label: {
                        Text(itemViewModel.item.title)
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
    @Bindable var itemViewModel: ItemViewModel // @Bindable works now as it is instantiating an @Observable viewmodel
    
    var body: some View {
        Form {
            TextField("Title", text: $itemViewModel.item.title)
        }
    }
}

#Preview("ItemDetailView") {
    ItemDetailView(
        itemViewModel: (ItemViewModel(item: Item()))
    )
}

//MARK: ViewModel Layer
import Observation //required to use the new, well, observation stuff

@Observable final class ItemsViewModel {
    var itemViewModels: [ItemViewModel] = .init() //not providing a default value here (despite having an initialiser!) results in the error message `@Observable requires property 'items' to have an initial value (from macro 'Observable')`
    //seems to be a beta issue
    
    init(
        itemViewModels: [ItemViewModel] = .init()
    ) {
        self.itemViewModels = itemViewModels
    }
}

@Observable final class ItemViewModel: Identifiable {
    var id: UUID { item.id }
    var item: Item = .init()
    
    init(item: Item = Item(title: "New Item")) {
        self.item = item
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
