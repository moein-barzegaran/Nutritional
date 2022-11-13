//
//  FoodRepository.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/9/22.
//

import Foundation
import Combine

protocol FoodRepository {
    func getFoodDetails(id: Int) -> AnyPublisher<FoodNutritionalInfo?, Error> 
}
