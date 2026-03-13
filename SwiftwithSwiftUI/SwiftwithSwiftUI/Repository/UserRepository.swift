//
//  UserRepository.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 06/09/2025.
//

protocol UserRepository {
    func fetchUsers() async throws -> [User]
}
