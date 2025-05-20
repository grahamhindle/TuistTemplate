import SwiftUI
import TuistAppKit

@main
struct TuistApp: App {
    let kit = TuistAppKit()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print("Server has started")
                }
        }
    }
}
