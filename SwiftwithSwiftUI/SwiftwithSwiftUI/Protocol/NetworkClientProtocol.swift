//
//  NetworkClientProtocol.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 20/09/2025.
//

import Foundation

protocol NetworkClientProtocol {
    func load<Response: Decodable>(_ request: URLRequest, responseType: Response.Type) async throws -> Response
}
