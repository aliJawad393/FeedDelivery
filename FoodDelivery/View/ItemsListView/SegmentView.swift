//
//  HeaderView.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 10/09/2021.
//

import Foundation
import UIKit

final class SegmentView: UIView {
    
    private var selectedIndex: Int = 0
    private var items: [String]
    private let selection: (Int)->()
    
    //MARK: UIView Components
    private lazy var stackViewVertical: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 20
        view.addArrangedSubview(collectionView)
        view.addArrangedSubview(UIView())
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.estimatedItemSize = CGSize(width: 100, height: 50)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.delegate = self
        view.backgroundColor = .systemBackground
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.allowsMultipleSelection = false
        return view
    }()
    
    //MARK: Init
    init(items: [String], selection: @escaping(Int)->()) {
        self.items = items
        self.selection = selection
        super.init(frame: .zero)
        addSubview(stackViewVertical)
        NSLayoutConstraint.activate([
            stackViewVertical.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackViewVertical.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackViewVertical.topAnchor.constraint(equalTo: topAnchor),
            stackViewVertical.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 100 : 60)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SegmentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? HeaderCollectionViewCell {
            cell.setTitleText(items[indexPath.row])
        }
        if(indexPath.row == selectedIndex) {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
            cell.isSelected = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        selection(indexPath.row)
    }
    
}
