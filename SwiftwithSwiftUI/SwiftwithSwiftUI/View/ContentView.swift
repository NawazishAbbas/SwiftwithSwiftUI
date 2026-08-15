//
//  ContentView.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 31/08/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = UsersViewModel(repository: APIUserRepository())
    
    @StateObject private var pm = ProductsViewModel(APIProductsRepository())
    
    var body: some View {
        NavigationView {
            ZStack {
                if pm.isRefreshing {
                    ProgressView()
                } else {
                    List {
                        ForEach(pm.products, id: \.id) { product in
                            ProductView(product: product)
                        }
                        
                        ForEach(vm.repoUsers, id: \.id) { user in
                            UserView(user: user)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Users List")
                }
            }
            .onAppear {
                Task {
                    await vm.loadUsers()
                    await pm.fetchProducts()
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry", action:
                        { Task {
                    await vm.loadUsers()
                    await pm.fetchProducts()
                }
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
