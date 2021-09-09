//
//  ItemsListPresenter.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ItemsListPresenter {
    var items: BehaviorRelay<[FoodItem]>{ get }
}

final class FoodItemsListPresenter: ItemsListPresenter {
    var items: BehaviorRelay<[FoodItem]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    private let interactor: ItemsListInteractor
    private let router: ItemsListRouter
    
    //MARK: Init
    init(interactor: ItemsListInteractor, router: ItemsListRouter) {
        self.interactor = interactor
        self.router = router
        interactor.getFoodItems()
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] response in
                self?.items.accept(response)
                print("Received response in presenter \(response)")
            } onFailure: { error in
                print("Error in presenter \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
    
    func getFoodItems() -> Single<[FoodItem]> {
        interactor.getFoodItems()
    }
}
