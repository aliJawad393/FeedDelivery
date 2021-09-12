//
//  ImageDetailViewController.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 12/09/2021.
//

import Foundation
import UIKit

final class ItemDetailViewController: UIViewController {
    
    private lazy var labelMessage: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.textColor = UIColor(named: "itemsBgColor")
        view.text = "Item Detail - Not implemented yet"
        return view
    }()
    
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelMessage)
        NSLayoutConstraint.activate([
            labelMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
