//
//  APIClient.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 20/09/2025.
//

import Foundation

enum Endpoint: String {
    case usersList = "https://jsonplaceholder.typicode.com/users"
}

class APIClient: NetworkClientProtocol
{
    static let shared = APIClient()
    var error: UserError?
    
    func load<Response>() async throws -> Response where Response : Decodable {
        
        guard let url = URL(string: Endpoint.usersList.rawValue) else {
            error = UserError.custom(error: URLError(.badURL))
            throw UserError.custom(error: URLError(.badURL))
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Optional: check for bad HTTP response
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                if let _error = error {
                    error = UserError.custom(error: _error)
                }
            }
            
            let decoder = JSONDecoder()
            
            do {
                let users = try decoder.decode(Response.self, from: data)
                return users
            } catch {
                self.error = .failedToDecode
                throw UserError.failedToDecode
            }
            
        } catch {
            self.error = .custom(error: error)
            throw error
        }
    }
}
