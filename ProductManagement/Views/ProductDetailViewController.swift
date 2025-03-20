//
//  ProductDetailViewController.swift
//  ProductManagement
//
//  Created by Anjali Sikarwar on 20/03/25.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        guard let product = product else { return }

        productName.text = product.title
        productRating.text = "Rating: \(product.rating.rate) (\(product.rating.count) reviews)"
        productPrice.text = "Price: $\(product.price)"
        productCategory.text = "Category: \(product.category)"
        productDescription.text = product.description

        if let url = URL(string: product.image){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.productImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
