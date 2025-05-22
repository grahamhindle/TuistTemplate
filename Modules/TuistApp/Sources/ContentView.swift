//  ContentView.swift

import ComposableArchitecture
import Inject
import SwiftUI
import UIFramework

struct ContentView: View {
    @ObserveInjection var inject
    var body: some View {
        VStack {
            UIFrameworkView() // This view needs to be imported from TuistAppKit module
        }
        .padding()
        .enableInjection()
    }
}
