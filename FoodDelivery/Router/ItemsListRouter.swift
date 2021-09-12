//
//  ItemsListRouter.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import Foundation
import UIKit

protocol ItemsListRouter {
    func showItemDetail(item: ListItem)
}

final class FoodItemsListRouter: ItemsListRouter {
    private let navigationController: UINavigationController
    private var factory: ViewControllerFactory
    //MARK: Init
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func showItemDetail(item: ListItem) {
        navigationController.isNavigationBarHidden = false
        let backButtonItem = UIBarButtonItem(title: "Menu", style: .done, target: self, action: #selector(backAction(sender:)))
        backButtonItem.tintColor = UIColor(named: "itemsBgColor")
        let controller = factory.createItemDetailVC()
        controller.navigationItem.leftBarButtonItem = backButtonItem
        navigationController.show(controller, sender: nil)
    }
    
    @objc func backAction(sender: AnyObject) {
        navigationController.popViewController(animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
}
