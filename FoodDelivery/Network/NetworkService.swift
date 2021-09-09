//
//  NetworkService.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 08/09/2021.
//

import Foundation
import Moya

enum NetworkService {
    case foodItemsList
}

extension NetworkService: TargetType {
    var baseURL: URL {
        URL(string: "https://baseUrl.com")!
    }
    
    var path: String {
        "/path"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var sampleData: Data {
        // Read JSON from file
        guard let url = Bundle.main.url(forResource: "foodItems", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return Data()
        }
        return data
    }
}
