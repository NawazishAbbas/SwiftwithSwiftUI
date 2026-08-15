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

public enum HttpMethodType: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIDomain: String {
    case users
    case products
}

class BaseRequest: Request {
    
    internal var domain: APIDomain {
        .users
    }
    
    internal var methodType: HttpMethodType {
        .get
    }
    
    func urlRequest() -> URLRequest? {
        guard var baseUrl = self.baseURL() else { return nil }
        if let endPoint = self.endPoint() {
            baseUrl = baseUrl + endPoint
        }
        
        let url = URL(string: baseUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        return request
    }
    
    func endPoint() -> String? {
        return nil
    }
}

extension BaseRequest {
    private func baseURL() -> String? {
        if self.domain == .users {
            return NetworkConfiguration.NetworkClient.userBaseUrl
        } else if self.domain == .products {
            return NetworkConfiguration.NetworkClient.productBaseUrl
        }
        
        return nil
    }
}
