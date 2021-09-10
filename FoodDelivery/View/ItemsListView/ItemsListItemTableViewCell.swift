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
        view.spacing = 20
        view.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.isLayoutMarginsRelativeArrangement = true
        view.addArrangedSubview(imageViewItem)
        view.addArrangedSubview(labelItemName)
        view.addArrangedSubview(labelIngredients)
        view.addArrangedSubview(stackViewHorizontal)
        view.addArrangedSubview(UIView())
        view.setCustomSpacing(5, after: labelItemName)
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
    
    private lazy var labelItemName: UILabel = {
        let view = UILabel()
        view.font = UIFont.montserratSemiBold.withAdjustableSize(20)
        view.text = "Deluxe"
        return view
    }()
    
    private lazy var labelIngredients: UILabel = {
        let view = UILabel()
        view.font = UIFont.montserratRegular.withAdjustableSize(12)
        view.numberOfLines = 0
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.textColor = .systemGray
        view.text = "Chickem, pepperoni, tomato, sauce, spicy chorizo"
        return view
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.addArrangedSubview(labelWeight)
        view.addArrangedSubview(UIView())
        return view
    }()
    
    private lazy var labelWeight: UILabel = {
        let view = UILabel()
        view.font = UIFont.montserratRegular.withAdjustableSize(13)
        view.numberOfLines = 0
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.textColor = .systemGray
        view.text = "150 grams, 35 cm"
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
