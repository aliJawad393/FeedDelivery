//
//  ItemsListInteractor.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

protocol ItemsListInteractor {
    func getFoodItems() -> Single<[FoodItem]>
}

final class FoodItemsListInteractor: ItemsListInteractor {
    private lazy var provider = MoyaProvider<NetworkService>(stubClosure: MoyaProvider.immediatelyStub)
    
    func getFoodItems() -> Single<[FoodItem]> {
        provider.rx.request(.foodItemsList)
            .observe(on: MainScheduler.instance)
            .mapJSON()
            .map{response -> [FoodItem] in
                Mapper<FoodItemsList>().map(JSONObject: response)?.items ?? []
            }
    }
}


