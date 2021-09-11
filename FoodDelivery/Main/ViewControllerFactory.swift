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
}

final class iOSUIKitViewControllerFactory: ViewControllerFactory {
    func createItemsListVC() -> UIViewController {
        let presenter = FoodItemsListPresenter(interactor: FoodItemsListInteractor(), router: FoodItemsListRouter())
        let headerView = SegmentView(items: [Categories.pizza.title, Categories.sushi.title, Categories.drinks.title, Categories.burgers.title, Categories.pastas.title], selection: {selectedItem in
            presenter.selectItem(atIndex: selectedItem)
        })
        
        return ItemsListViewController(presenter: presenter, headerView: headerView)
    }
}
