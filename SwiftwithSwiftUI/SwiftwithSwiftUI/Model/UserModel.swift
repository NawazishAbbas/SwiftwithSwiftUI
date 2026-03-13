//
//  UserModel.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 01/09/2025.
//

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let company: Company
}

struct Company: Codable {
    let name: String
}
