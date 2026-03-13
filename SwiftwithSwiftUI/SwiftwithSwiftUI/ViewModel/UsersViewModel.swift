//
//  UsersViewModel.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 01/09/2025.
//

import Foundation

@MainActor final class UsersViewModel: ObservableObject {
    var users: [User] = []
    @Published var hasError = false
    @Published var error: UserError?
    @Published private(set) var isRefreshing = false
    
    @Published var repoUsers: [User] = []
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func loadUsers() async {
        isRefreshing = true
        do {
            let users = try await repository.fetchUsers()
            self.isRefreshing = false
            self.repoUsers = users
        } catch {
            isRefreshing = false
            self.hasError = true
            self.error = UserError.custom(error: error)
            #if DEBUG
            print("Error: \(error)")
#endif
        }
    }
}
