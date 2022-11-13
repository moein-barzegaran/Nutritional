//
//  FoodProviding.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/12/22.
//

import Foundation
import Combine

// FoodEndpoint...

public enum FoodEndpoint {
    case getFoodDetail(id: Int)
}

extension FoodEndpoint: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.lifesum.com/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getFoodDetail:
            return "/foodipedia/codetest"
        }
    }
    
    var version: String {
        "v2"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getFoodDetail(let id):
            return .requestParameters(urlParameters: ["foodid": id])
        }
    }
}
