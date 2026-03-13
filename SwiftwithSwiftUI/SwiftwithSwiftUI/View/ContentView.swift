//
//  ContentView.swift
//  SwiftwithSwiftUI
//
//  Created by Nawazish Abbas on 31/08/2025.
//

import SwiftUI

struct ContentView: View {    
    @StateObject private var vm = UsersViewModel(repository: APIUserRepository())
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    List {
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
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry", action:
                        { Task {
                    await vm.loadUsers()
                    
                }
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
