import SwiftUI


@main
struct TuistApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print("Server has started")
                }
        }
    }
}
