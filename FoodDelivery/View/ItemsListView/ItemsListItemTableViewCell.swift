//
//  ItemsListItemTableViewCell.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 09/09/2021.
//

import Foundation
import UIKit
import Kingfisher

struct ListItem {
    let name: String
    let imageURL: URL
    let ingredients: String
    let price: String
    let properties: String
    
    init?(name: String, imageURL: String, ingredients: [String], price: Float, weight: Float, size: Int) {
        guard let imageURL = URL(string: imageURL) else {return nil}
        self.name = name
        self.imageURL = imageURL
        self.ingredients = ingredients.joined(separator: " ")
        self.price = "\(price) usd"
        self.properties = "\(weight) grams, \(weight) cm"
    }
    
}

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
        view.addArrangedSubview(buttonAddToCart)
        return view
    }()
    
    private lazy var labelWeight: UILabel = {
        let view = UILabel()
        view.font = UIFont.montserratRegular.withAdjustableSize(13)
        view.textColor = .systemGray
        view.text = "150 grams, 35 cm"
        return view
    }()
    
    private lazy var buttonAddToCart: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor(named: "itemsBgColor")
        view.setTitleColor(.systemBackground, for: .normal)
        view.titleLabel?.font = UIFont.montserratRegular.withAdjustableSize(12)
        view.setTitle("55 usd", for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonAddToCart.layoutIfNeeded()
        buttonAddToCart.layer.cornerRadius = buttonAddToCart.bounds.size.height / 2
        buttonAddToCart.clipsToBounds = true
    }
    
    //MARK: Internal
    func setData(_ data: ListItem) {
        labelItemName.text = data.name
        labelIngredients.text = data.ingredients
        labelWeight.text = data.properties
        buttonAddToCart.setTitle(data.price, for: .normal)
        imageViewItem.kf.setImage(with: data.imageURL, placeholder: UIImage(named: "placeholder"))
        imageViewItem.kf.indicatorType = .activity
    }
    
}

//MARK: Setup View
private extension ItemsListItemTableViewCell {
    private func setupView() {
        contentView.addSubview(stackView)
        selectionStyle = .none
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
