//
//  ViewController.swift
//  5M1stHomeWork
//
//  Created by user on 26/5/23.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet private weak var deliveryCollectioView: UICollectionView!
    @IBOutlet private weak var categoryCollectioView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tabbar: UITabBar!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var productNum: UILabel!
    
    private let images: [UIImage?] = [
        UIImage(named: "pic1"),
        UIImage(named: "pic2"),
        UIImage(named: "pic3"),
        UIImage(named: "pic4"),
        UIImage(named: "pic1"),
        UIImage(named: "pic2")
    ]
    private let cvBText: [String] = [
        "Grociery",
        "Pharmacy",
        "Takeaway",
        "Convince",
        "Takeaway",
        "Grociery"
    ]
    
    private let networkService = NetworkService()
    private var products: [Product] = []
    private var filteredProducts: [Product] = []
    private var isFiltered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        setUp()
    }

    func setUp() {
        configureTableView()
        configureSearchBar()
        configureCollectionView()
    }
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: ProductTableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: ProductTableViewCell.reuseId
        )
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func configureCollectionView() {
        deliveryCollectioView.dataSource = self
        categoryCollectioView.dataSource = self
        
        deliveryCollectioView.delegate = self
        categoryCollectioView.delegate = self
        
        deliveryCollectioView.register(
            UINib(
                nibName: DeliveryCell.nibName,
                bundle: nil),
            forCellWithReuseIdentifier: CategoryCell.reuseId)
        categoryCollectioView.register(
            UINib(
                nibName: CategoryCell.nibName,
                bundle: nil),
            forCellWithReuseIdentifier: CategoryCell.reuseId)
    }
    
    private func fetchProducts() {
        Task {
            do {
                let response = try await networkService.requestProducts()
                DispatchQueue.main.async {
                    self.products = response.products
                    self.tableView.reloadData()
                }
            } catch {
                
            }
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        isFiltered ? filteredProducts.count : products.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseId, for: indexPath) as! ProductTableViewCell
        productNum.text = "\(isFiltered ? filteredProducts.count : products.count) products aviable"
        let model = isFiltered ? filteredProducts[indexPath.row] : products[indexPath.row]
        cell.display(item: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        330
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ProductViewController:
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        if collectionView == deliveryCollectioView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DeliveryCell.reuseId,
                for: indexPath) as? DeliveryCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.reuseId,
                for: indexPath) as? CategoryCell else {
                return UICollectionViewCell()
            }
            cell.display(
                image: images[indexPath.row],
                text: cvBText[indexPath.row]
            )
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        if collectionView == deliveryCollectioView {
            return CGSize(width: 110, height: 40)
        } else {
            return CGSize(width: 80, height: 150)
        }
    }
}

//MARK: - UISearchBarDelegates
extension ProductViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isFiltered = false
        } else {
            isFiltered = true
            filteredProducts = products.filter{ $0.title.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}
