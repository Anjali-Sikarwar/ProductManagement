//
//  APIService.swift
//  ProductManagement
//
//  Created by Anjali Sikarwar on 20/03/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func fetchProducts(limit: Int, offset: Int, completion: @escaping (Result<[Product], Error>)-> Void) {
        
        let urlString = "https://fakestoreapi.com/products?limit=\(limit)&offset=\(offset)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
