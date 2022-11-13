//
//  DefaultFoodRepository.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/9/22.
//

import Foundation
import Combine

final class DefaultFoodRepository {

    private var cancellable = Set<AnyCancellable>()
    private let router: Router<FoodEndpoint>

    init(router: Router<FoodEndpoint> = Router<FoodEndpoint>()) {
        self.router = router
    }
}

extension DefaultFoodRepository: FoodRepository {
    func getFoodDetails(id: Int) -> AnyPublisher<FoodNutritionalInfo?, Error> {
        return router.request(.getFoodDetail(id: id))
            .tryMap { (result: GeneralResponseDTO<FoodNutritionalInfoDTO>) -> FoodNutritionalInfo? in
                result.response?.toDomain()
            }
            .eraseToAnyPublisher()
    }
}
