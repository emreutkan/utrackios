import Foundation
import Combine
class AuthManager: ObservableObject {
    static let shared = AuthManager() // Singleton instance of the auth manager
    private var accessToken: String?
    private var refreshToken: String?

    @Published var isAuthenticated = false // Add @Published property 

    // To switch screens after a successful login, the standard SwiftUI way is to have a root view that decides what to show based on your AuthManager state


    private init() {
        self.accessToken = nil
        self.refreshToken = nil
        self.isAuthenticated = false
    }
    

    func saveTokens(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.isAuthenticated = true // Update state

    }

    func getAccessToken() -> String? {
        return self.accessToken
    }
    
    func getRefreshToken() -> String? {
        return self.refreshToken
    }

    func clearTokens() {
        self.accessToken = nil
        self.refreshToken = nil
        self.isAuthenticated = false
    }


    func logout() {
        self.accessToken = nil
        self.refreshToken = nil
        self.isAuthenticated = false
    }

    func refreshAccessToken() async throws -> String {

        // TODO: Implement refresh access token logic
        throw URLError(.badServerResponse)
    }
}