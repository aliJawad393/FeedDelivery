//
//  ImageSlider.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 11/09/2021.
//

import Foundation
import UIKit

final class ImageSlider: UIView {
    
    private var currentIndex: Int = 0
    private var imageNames: [String] = ["image-pizza", "image-pizza-2", "image-pizza", "image-pizza-2", "image-pizza"] // loading locally saved images
    private let segmentView: SegmentView
    
    //MARK: UIView Components
    private lazy var collectionViewMediaSlider: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DraftPreviewCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor(named: "itemsBgColor")
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var viewPageControl: UIPageControl = {
        let view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfPages = 5
        view.contentVerticalAlignment = .center
        view.currentPageIndicatorTintColor = UIColor(red: 0.796, green: 0.451, blue: 0.247, alpha: 1)
        view.pageIndicatorTintColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        return view
    }()
    
    
    //MARK: Init
    init(segmentView: SegmentView) {
        self.segmentView = segmentView
        super.init(frame: .zero)
        setupView()
        setupTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Internal
    func setAlpha(alpha: CGFloat) {
        collectionViewMediaSlider.alpha = alpha
        viewPageControl.alpha = alpha
    }
}

//MARK: Setup View
private extension ImageSlider {
    private func setupView() {
        addSubview(collectionViewMediaSlider)
        addSubview(viewPageControl)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segmentView)
        
        
        NSLayoutConstraint.activate([
            collectionViewMediaSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewMediaSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionViewMediaSlider.topAnchor.constraint(equalTo: topAnchor),
            collectionViewMediaSlider.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewPageControl.centerXAnchor.constraint(equalTo: collectionViewMediaSlider.centerXAnchor),
            viewPageControl.bottomAnchor.constraint(equalTo: segmentView.topAnchor, constant: -20),
            segmentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    //MARK: Private Helpers
    
    private func autoSlide() {
        currentIndex = currentIndex >= imageNames.count ? 0 : currentIndex
        collectionViewMediaSlider.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: true, scrollPosition: .right)
        currentIndex = currentIndex + 1
    }
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[weak self] timer in
            if let selfRef = self {
                selfRef.autoSlide()
            } else {
                timer.invalidate()
            }
        }
    }
}

extension ImageSlider: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? DraftPreviewCollectionViewCell {
            cell.setImage(image: UIImage(named: imageNames[indexPath.row]))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewPageControl.currentPage = indexPath.row
    }
}
