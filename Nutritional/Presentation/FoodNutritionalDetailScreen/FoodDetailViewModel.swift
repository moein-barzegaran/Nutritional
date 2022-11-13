//
//  FoodDetailViewModel.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import Foundation
import Combine

class FoodDetailViewModel: ObservableObject {
    
    private let id: Int
    private let foodInfoUseCase: FoodInfoUseCase
    
    private var cancellable = Set<AnyCancellable>()
    
    init(id: Int, foodInfoUseCase: FoodInfoUseCase = DefaultFoodInfoUseCase()) {
        self.id = id
        self.foodInfoUseCase = foodInfoUseCase
    }
    
    func onAppearAction() {
        foodInfoUseCase.getFoodDetails(id: id)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    Logger.log(error)
                    
                case .finished: break
                }
            } receiveValue: { [weak self] result in
                guard let self else { return }
                guard let result else { return }
                
                Logger.log(">>>Calories \(result.calories)")
            }
            .store(in: &cancellable)
    }
}

// MARK: - Private methods
private extension FoodDetailViewModel {
    func fetchFoodDetails() {
        
    }
}
