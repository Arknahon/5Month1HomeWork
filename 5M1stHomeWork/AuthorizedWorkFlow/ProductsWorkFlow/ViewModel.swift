//
//  ViewModel.swift
//  5M1stHomeWork
//
//  Created by user on 8/6/23.
//

import Foundation

class ProductsViewModel {
    
    let networkService: NetworkService
    
    init() {
        self.networkService = NetworkService()
    }
    
    func fetchProducts() async throws -> [Product] {
        try await networkService.requestProducts().products
    }
}
