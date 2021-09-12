//
//  ItemsListPresenter.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum Categories: Int {
    case pizza = 0
    case sushi
    case drinks
    case burgers
    case pastas
    
    var title: String {
        switch self {
        case .pizza:
            return "Pizza"
        case .sushi:
            return "Sushi"
        case .drinks:
            return "Drinks"
        case .burgers:
            return "Burgers"
        case .pastas:
            return "Pastas"
        }
    }
    
    var slug: String {
        switch self {
        case .pizza:
            return "pizza"
        case .sushi:
            return "sushi"
        case .drinks:
            return "drinks"
        case .burgers:
            return "burgers"
        case .pastas:
            return "pastas"
        }
    }
}

protocol ItemsListPresenter {
    var items: BehaviorRelay<[ListItem]>{ get }
    var error: PublishRelay<Error>{get}
    func selectMenuItem(atIndex index: Int)
    func selectFoodItem(atIndex index: Int)
}

final class FoodItemsListPresenter: ItemsListPresenter {
    var items: BehaviorRelay<[ListItem]> = BehaviorRelay(value: [])
    var error: PublishRelay<Error> = PublishRelay()
    
    private let disposeBag = DisposeBag()
    private let interactor: ItemsListInteractor
    private let router: ItemsListRouter
    private var allItems: [FoodItem] = []
    //MARK: Init
    init(interactor: ItemsListInteractor, router: ItemsListRouter) {
        self.interactor = interactor
        self.router = router
        interactor.getFoodItems()
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] response in
                self?.allItems = response
                self?.items.accept(self?.mapAndFilter(allItems: response, category: Categories.pizza.slug) ?? [])
            } onFailure: {[weak self] error in
                self?.error.accept(error)
            }.disposed(by: disposeBag)
    }
    
    func getFoodItems() -> Single<[FoodItem]> {
        interactor.getFoodItems()
    }
    
    func selectMenuItem(atIndex index: Int) {
        items.accept(mapAndFilter(allItems: allItems, category: Categories(rawValue: index)?.slug ?? ""))
    }
    
    func selectFoodItem(atIndex index: Int) {
        router.showItemDetail(item: items.value[index])
    }
    
    //MARK: Private Helpers
    private func mapAndFilter(allItems: [FoodItem], category: String) -> [ListItem] {
        let filteredItems = allItems.filter{$0.category == category}
        return filteredItems.compactMap { item in
            ListItem(foodItem: item)
        }
    }
}
