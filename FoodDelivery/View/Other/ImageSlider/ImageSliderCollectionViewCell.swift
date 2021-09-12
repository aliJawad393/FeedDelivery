//
//  ImageSliderCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 11/09/2021.
//

import Foundation
import UIKit

final class DraftPreviewCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView =  {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.image = UIImage(named: "image-pizza")
        view.contentMode = .scaleToFill
        return view
    }()
        
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    //MARK: Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup View
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
    
    //MARK: Internal Methods
    
    func setImage(image: UIImage?) {
        loadingIndicator.stopAnimating()
        if let image = image {
            imageView.image = image
        }
    }
}

