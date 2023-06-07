//
//  ViewController.swift
//  5M1stHomeWork
//
//  Created by user on 26/5/23.
//

import UIKit

class ProductViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet private weak var deliveryCollectioView: UICollectionView!
    @IBOutlet private weak var categoryCollectioView: UICollectionView!
    @IBOutlet private weak var productTableView: UITableView!
    @IBOutlet private weak var tabbar: UITabBar!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var productNum: UILabel!
    
    private let networkService = NetworkService()
    private var products: [Product] = []
    private let categories = [
        Category(CategoryImage: "pic1", CategoryText: "Takeaways"),
        Category(CategoryImage: "pic2", CategoryText: "Grocery"),
        Category(CategoryImage: "pic3", CategoryText: "Conveniece"),
        Category(CategoryImage: "pic4", CategoryText: "Pharmacy"),
        Category(CategoryImage: "pic1", CategoryText: "Takeaways")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct()
        configureTableView()
        configureCollectionView()
    }
    
    private func fetchProduct() {
        networkService.ProductRequest { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.products = response.products
                    self.productTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func fetch() {
        Task {
            do {
                let response = try await networkService.ProductRequest()
                DispatchQueue.main.async {
                    self.products = response.products
                    self.productTableView.reloadData()
                }
            } catch {
                //alert
            }
        }
    }
    
    private func configureTableView() {
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(
            UINib(
                nibName: ProductTableViewCell.nibName,
                bundle: nil
            ),
            forCellReuseIdentifier: ProductTableViewCell.reuseId
        )
    }
    private func configureCollectionView() {
        categoryCollectioView.dataSource = self
        deliveryCollectioView.dataSource = self
        
        categoryCollectioView.delegate = self
        deliveryCollectioView.delegate = self
        
        categoryCollectioView.register(
            UINib(
                nibName: CategoryCell.nibName,
                bundle: nil
            ), forCellWithReuseIdentifier: CategoryCell.reuseId
        )
        deliveryCollectioView.register(
            UINib(
                nibName: DeliveryCell.nibName,
                bundle: nil
            ), forCellWithReuseIdentifier: DeliveryCell.reuseId
        )
    }
}

extension ProductViewController:
    UITableViewDataSource,
    UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.reuseId,
            for: indexPath) as! ProductTableViewCell
        let model = products[indexPath.row]
        cell.display(item: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}

extension ProductViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == categoryCollectioView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
            let model = categories[indexPath.row]
            cell.display(item: model)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryCell.reuseId, for: indexPath) as! DeliveryCell
            return cell
        }
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == categoryCollectioView {
            return CGSize(width: 80, height: 150)
        } else {
            return CGSize(width: 110, height: 40)
        }
        
    }
}
