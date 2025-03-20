//
//  ProductListViewController.swift
//  ProductManagement
//
//  Created by Anjali Sikarwar on 20/03/25.
//

import Foundation
import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        fetchData()
    }

    private func fetchData() {
        viewModel.fetchProducts { [weak self] error in
            if let error = error {
                print("Error fetching products: \(error)")
            } else {
                self?.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        if let product = viewModel.product(at: indexPath.row) {
            cell.configure(with: product)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.productsCount - 1 {
            fetchData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = viewModel.product(at: indexPath.row) else { return }
//        viewModel.performHeavyComputation(product: product) { [weak self] details in
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        detailVC.product = product // Pass the product
        self.navigationController?.pushViewController(detailVC, animated: true)
//        }
    }
}
