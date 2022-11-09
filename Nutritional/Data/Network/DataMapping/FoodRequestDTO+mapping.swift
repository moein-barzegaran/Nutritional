//
//  FoodRequestDTO+mapping.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/9/22.
//

import Foundation

struct FoodRequestDTO: Encodable {
    let foodId: Int
    
    enum CodingKeys: String, CodingKey {
        case foodId = "foodid"
    }
}
