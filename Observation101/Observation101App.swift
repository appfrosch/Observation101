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

//MARK: Model Layer
