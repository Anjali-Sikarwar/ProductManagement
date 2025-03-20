//
//  ProductViewModel.swift
//  ProductManagement
//
//  Created by Anjali Sikarwar on 20/03/25.
//

import Foundation

class ProductViewModel {
    private var products: [Product] = []
    private var limit = 10
    private var offset = 0
    private var isLoading = false

    var productsCount: Int {
        return products.count
    }

    func product(at index: Int) -> Product? {
        guard index < products.count else { return nil }
        return products[index]
    }

    func fetchProducts(completion: @escaping (Error?) -> Void) {
        guard !isLoading else { return }
        isLoading = true

        APIService.shared.fetchProducts(limit: limit, offset: offset) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let newProducts):
                    self?.products.append(contentsOf: newProducts)
                    self?.offset += self?.limit ?? 0
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }

    func performHeavyComputation(product: Product, completion: @escaping (String) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let startTime = Date()
            
            let computedDetails = "Details computed for \(product.title). Price: \(product.price)"
            let endTime = Date()
            let timeTaken = endTime.timeIntervalSince(startTime)
            print("Heavy computation time: \(timeTaken) seconds")

            DispatchQueue.main.async {
                completion(computedDetails)
            }
        }
    }
}
