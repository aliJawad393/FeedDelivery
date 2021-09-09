//
//  ItemsListItemTableViewCell.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 09/09/2021.
//

import Foundation
import UIKit

final class ItemsListItemTableViewCell: UITableViewCell {
    
    //MARK: UIView Components
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.addArrangedSubview(imageViewItem)
        view.addArrangedSubview(UIView())
        return view
    }()
    
    private lazy var imageViewItem: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "image-pizza")
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20.0
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Setup View
private extension ItemsListItemTableViewCell {
    private func setupView() {
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
