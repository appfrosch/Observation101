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
}
