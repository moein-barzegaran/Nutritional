//
//  FoodNutritionalInfoUseCase.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/9/22.
//

import Foundation
import Combine

protocol FoodInfoUseCase {
    func execute(id: Int) -> AnyPublisher<FoodNutritionalInfo, Error>
}

final class DefaultFoodInfoUseCase: FoodInfoUseCase {

    private let foodRepository: FoodRepository

    init(foodRepository: FoodRepository) {

        self.foodRepository = foodRepository
    }

    func execute(id: Int) -> AnyPublisher<FoodNutritionalInfo, Error> {

        return foodRepository
            .fetchFoodNutritionalInfo(id: id)
    }
}
