//
//  FoodItem.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 08/09/2021.
//

import Foundation
import ObjectMapper

struct FoodItem {
    var name: String?
}

extension FoodItem: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name  <- map["name"]
    }
}
