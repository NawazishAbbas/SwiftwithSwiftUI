//
//  ProductsRepository.swift
//  SwiftwithSwiftUI
//
//  Created by Qubitse on 16/08/2026.
//

protocol ProductsRepository {
    func fetchProducts() async throws -> ProductsModel
}
