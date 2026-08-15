//
//  NetworkConfigurations.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 13/08/2026.
//

struct NetworkConfiguration {
    struct NetworkClient {
        static let userBaseUrl = "https://jsonplaceholder.typicode.com"
        static let productBaseUrl = "https://dummyjson.com"

        struct API {
            static let getUsers = "/users"
            static let getProduct = "/products"
        }
    }
}
