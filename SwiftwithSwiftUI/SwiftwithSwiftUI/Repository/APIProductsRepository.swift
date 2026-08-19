//
//  APIProductsRepository.swift
//  SwiftwithSwiftUI
//
//  Created by Qubitse on 16/08/2026.
//

class APIProductsRepository: ProductsRepository {
    func fetchProducts() async throws -> ProductsModel {
        let client = try await APIClient.shared.load(FetchProductRequest(), responseType: ProductsModel.self)
        return client
    }
}
