//
//  ViewController+Extension.swift
//  5M1stHomeWork
//
//  Created by user on 8/6/23.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Okat", style: .cancel))
        self.present(alert, animated: true)
    }
}

