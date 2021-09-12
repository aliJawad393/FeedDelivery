//
//  HeaderCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 10/09/2021.
//

import Foundation
import UIKit

final class HeaderCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            labelTitle.textColor = isSelected ? UIColor(named: "itemsBgColor") : .systemGray
        }
    }
    //MARK: UIView Components
    private lazy var labelTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.montserratSemiBold.withAdjustableSize(25)
        view.textColor = isSelected ? UIColor(named: "itemsBgColor") : .systemGray
        view.text = "Pizza"
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Internal
    func setTitleText(_ text: String) {
        labelTitle.text = text
    }
}

//MARK: Setup View
private extension HeaderCollectionViewCell {
    private func setupView() {
        contentView.addSubview(labelTitle)
        NSLayoutConstraint.activate([
            labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
