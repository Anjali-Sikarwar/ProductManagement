//
//  ProductTableViewCell.swift
//  ProductManagement
//
//  Created by Anjali Sikarwar on 20/03/25.
//

import Foundation
import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        categoryLabel.text = product.category
        productImageView.layer.cornerRadius = 8
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
