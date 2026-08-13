//
//  BaseRequest.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 13/08/2026.
//

import Foundation
import UIKit

protocol Request {
    func urlRequest() -> URLRequest?
}

class BaseRequest: Request {
    
    func urlRequest() -> URLRequest? {
        guard var baseUrl = self.baseURL() else { return nil }
        if let endPoint = self.endPoint() {
            baseUrl = baseUrl + endPoint
        }
        
        let url = URL(string: baseUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func endPoint() -> String? {
        return nil
    }
    
}

extension BaseRequest {
    private func baseURL() -> String? {
        return NetworkConfiguration.NetworkClient.baseUrl
    }
}
