import Foundation // Foundation framework is used for networking operations

class APIService {
    static let shared = APIService() // Singleton instance of the API service
    private static let API_URL = "http://192.168.1.9:8000/"
    private static let LOGIN_URL = API_URL + "api/user/login"

    func login(email: String, password: String) async throws -> (access: String, refresh: String) {
        var request = URLRequest(url: URL(string: Self.LOGIN_URL)!) // Create a URL request for the login endpoint 
        request.httpMethod = "POST" // Set the HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set the content type to JSON

        let body = [
            "email": email,
            "password": password
        ] // Create a body for the request


        request.httpBody = try JSONEncoder().encode(body) // try to encode the body to JSON data

        let (data, response) = try await URLSession.shared.data(for: request) // create a data task to send the request and get the data and response

       
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        } // if the response is not 200, throw an error

        // response is expected as a access token and refresh token string in JSON format
        // {
        //     "access": "string",
        //     "refresh": "string"
        // }
        let responseBody = try JSONDecoder().decode([String: String].self, from: data)

        // return the access and refresh tokens if they are present, otherwise throw an error
        guard let accessToken = responseBody["access"], let refreshToken = responseBody["refresh"] else {
            throw URLError(.badServerResponse)
        }

        return (access: accessToken, refresh: refreshToken)
    }
}
