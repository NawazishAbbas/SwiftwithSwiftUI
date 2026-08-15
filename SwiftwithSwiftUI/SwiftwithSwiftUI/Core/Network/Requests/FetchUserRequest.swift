//
//  FetchUserRequest.swift
//  SwiftwithSwiftUI
//
//  Created by Qubitse on 14/08/2026.
//

class FetchUserRequest: BaseRequest {
    override func endPoint() -> String? {
        NetworkConfiguration.NetworkClient.API.getUsers
    }
    
    override var domain: APIDomain {
        .users
    }
}
