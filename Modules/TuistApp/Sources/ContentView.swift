//  ContentView.swift

import ComposableArchitecture
import Inject
import SwiftUI

struct ContentView: View {
    @ObserveInjection var inject
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, World!")
        }
        .padding()
        .enableInjection()
    }
}
