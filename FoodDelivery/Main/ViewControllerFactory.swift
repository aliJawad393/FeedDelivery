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
        return ItemsListViewController(presenter: FoodItemsListPresenter(interactor: FoodItemsListInteractor(), router: FoodItemsListRouter()))
    }
}
