//
//  FoodNutritionalInfoUseCase.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/9/22.
//

import Foundation
import Combine

protocol FoodInfoUseCase {
    func getFoodDetails(id: Int) -> AnyPublisher<FoodNutritionalInfo?, Error>
}

final class DefaultFoodInfoUseCase: FoodInfoUseCase {

    private let foodRepository: FoodRepository

    init(foodRepository: FoodRepository = DefaultFoodRepository()) {
        self.foodRepository = foodRepository
    }

    func getFoodDetails(id: Int) -> AnyPublisher<FoodNutritionalInfo?, Error> {
        foodRepository.getFoodDetails(id: id)
    }
}
