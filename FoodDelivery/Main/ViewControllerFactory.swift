//
//  ViewControllerFactory.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import Foundation
import UIKit

protocol ViewControllerFactory {
    func createItemsListVC() -> UIViewController
    func createItemDetailVC() -> UIViewController
}

final class iOSUIKitViewControllerFactory: ViewControllerFactory {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func createItemsListVC() -> UIViewController {
        let presenter = FoodItemsListPresenter(interactor: FoodItemsListInteractor(), router: FoodItemsListRouter(navigationController: navigationController, factory: self))
        let segmentView = SegmentView(items: [Categories.pizza.title, Categories.sushi.title, Categories.drinks.title, Categories.burgers.title, Categories.pastas.title], selection: {selectedItem in
            presenter.selectMenuItem(atIndex: selectedItem)
        })
        
        let imageSlider = ImageSlider(segmentView: segmentView)
        
        return ItemsListViewController(presenter: presenter, headerView: imageSlider, selectItem: { index in
            presenter.selectFoodItem(atIndex: index)
        })
    }
    
    func createItemDetailVC() -> UIViewController {
        ItemDetailViewController()
    }
}
