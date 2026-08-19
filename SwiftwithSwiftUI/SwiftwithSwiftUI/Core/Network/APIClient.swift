//
//  APIClient.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 20/09/2025.
//

import Foundation

class APIClient: NetworkClientProtocol
{
    static let shared = APIClient()
    var error: UserError?

    func load<Response>(_ request: any Request, responseType: Response.Type) async throws -> Response where Response : Decodable {
        guard let uRLRequest = request.urlRequest() else {
            error = UserError.custom(error: URLError(.badURL))
            throw UserError.custom(error: URLError(.badURL))
        }
        
        return try await execute(uRLRequest, responseType: responseType)
    }
        
    private func execute<Response: Decodable>(_ request: URLRequest, responseType: Response.Type) async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard response is HTTPURLResponse else {
            throw UserError.failedToDecode
        }
        
        return try handleResponse(data: data, response: response, responseType: responseType)
    }
    
    private func handleResponse<Response: Decodable>(data: Data, response: URLResponse, responseType: Response.Type) throws -> Response {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UserError.failedToDecode
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw UserError.failedToDecode
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}
