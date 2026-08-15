//
//  FetchProductRequest.swift
//  SwiftwithSwiftUI
//
//  Created by Qubitse on 15/08/2026.
//


class FetchProductRequest: BaseRequest {
    override func endPoint() -> String? {
        NetworkConfiguration.NetworkClient.API.getProduct
    }

    override var domain: APIDomain {
        .products
    }
}
