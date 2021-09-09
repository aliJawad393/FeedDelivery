//
//  FoodItemsList.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 09/09/2021.
//

import Foundation
import ObjectMapper

struct FoodItemsList {
    var items: [FoodItem]?
}

extension FoodItemsList: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        items  <- map["items"]
    }
}
