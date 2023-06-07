//
//  CategoryCell.swift
//  5M1stHomeWork
//
//  Created by user on 6/6/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let reuseId = String(describing: CategoryCell.self)
    static let nibName = String(describing: CategoryCell.self)
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func display(image: UIImage?, text: String) {
        picture.image = image
        title.text = text
    }
}
