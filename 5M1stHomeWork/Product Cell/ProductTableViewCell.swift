//
//  ProductTableViewCell.swift
//  5M1stHomeWork
//
//  Created by user on 6/6/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    static let reuseId = String(describing: ProductTableViewCell.self)
    static let nibName = String(describing: ProductTableViewCell.self)
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    func display(item: Product) {
        let data = try? Data(contentsOf: URL(string: item.thumbnail)!)
        picture.image = UIImage(data: data!)
        productName.text = item.title
        rating.text = String(item.rating)
        productDescription.text = item.description
    }
}

