//
//  ItemsListPresenter.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import Foundation

protocol ItemsListPresenter {
    
}

final class FoodItemsListPresenter: ItemsListPresenter {
    private let interactor: ItemsListInteractor
    private let router: ItemsListRouter
    
    //MARK: Init
    init(interactor: ItemsListInteractor, router: ItemsListRouter) {
        self.interactor = interactor
        self.router = router
    }
}
