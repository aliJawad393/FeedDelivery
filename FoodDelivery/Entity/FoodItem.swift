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
    var imageUrl: String?
    var price: Float?
    var weight: Float?
    var size: Float?
    var ingredients: [String]?
    var category: String?
}

extension FoodItem: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name  <- map["name"]
        imageUrl <- map["imageURL"]
        price <- map["price"]
        weight <- map["weight"]
        size <- map["size"]
        ingredients <- map["ingredients"]
        category <- map["category"]
    }
}
