//
//  DeliveryCell.swift
//  5M1stHomeWork
//
//  Created by user on 26/5/23.
//

import UIKit

class DeliveryCell: UICollectionViewCell {
    static let reuseId = String(describing: DeliveryCell.self)
    static let nibName = String(describing: DeliveryCell.self)
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func layoutSubviews() {
        picture.image = UIImage(systemName: "person.fill")
        title.text = "Delivery"
        
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .orange
        title.textColor = .gray
        picture.tintColor = .gray
    }
}
