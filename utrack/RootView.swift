import SwiftUI


/// To switch screens after a successful login, the standard SwiftUI way is to have a root view that decides what to show based on your AuthManager state.
struct RootView: View {
    @StateObject private var shared = AuthManager.shared
    

    var body: some View {
        Group {
            if shared.isAuthenticated {
                HomeView()
            } else {
                ContentView()
            }
        }
    }
}
