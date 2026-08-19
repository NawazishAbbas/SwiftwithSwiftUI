//
//  ProductsViewModel.swift
//  SwiftwithSwiftUI
//
//  Created by Qubitse on 15/08/2026.
//

import Foundation

@MainActor final class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var hasError = false
    @Published var error: UserError?
    
    internal var repository: ProductsRepository
    @Published private(set) var isRefreshing = false
    init(_ repository: ProductsRepository) {
        self.repository = repository
    }
    
    func fetchProducts() async {
        isRefreshing = true
        do {
            let products = try await self.repository.fetchProducts()
            isRefreshing = false
            self.products = products.products ?? []
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
