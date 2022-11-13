//
//  FoodDetailViewModel.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import Foundation
import Combine

class FoodDetailViewModel: ObservableObject {
    
    struct ListData: Identifiable {
        let id = UUID().uuidString
        let title: String
        let value: String
    }
    
    @Published var foodTitle: String = ""
    @Published var calories: String = ""
    @Published var carbs: String = ""
    @Published var protein: String = ""
    @Published var fat: String = ""
    @Published var listDataSource: [ListData] = []
    
    @Published var isLoading = true
    
    private let id: Int
    private let foodInfoUseCase: FoodInfoUseCase
    
    private var cancellable = Set<AnyCancellable>()
    
    init(id: Int, foodInfoUseCase: FoodInfoUseCase = DefaultFoodInfoUseCase()) {
        self.id = id
        self.foodInfoUseCase = foodInfoUseCase
    }
    
    func onAppearAction() {
        isLoading = true
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
                
                self.foodTitle = result.title
                self.calories = String(result.calories)
                
                self.carbs = String(result.carbs)
                self.protein = String(result.protein)
                self.fat = String(result.fat)
                
                self.listDataSource = [
                    .init(title: "Carbs", value: String(result.carbs)),
                    .init(title: "Protein", value: String(result.protein)),
                    .init(title: "Fat", value: String(result.fat)),
                    .init(title: "Saturated Fat", value: String(result.saturatedfat)),
                    .init(title: "Unsaturated Fat", value: String(result.unsaturatedfat)),
                    .init(title: "Fiber", value: String(result.fiber)),
                    .init(title: "Cholesterol", value: String(result.cholesterol)),
                    .init(title: "Suger", value: String(result.sugar)),
                    .init(title: "Sodium", value: String(result.sodium)),
                    .init(title: "Potassium", value: String(result.potassium)),
                    .init(title: "Grams per serving", value: String(result.gramsperserving))
                ]
                
                self.isLoading = false
            }
            .store(in: &cancellable)
    }
}

// MARK: - Private methods
private extension FoodDetailViewModel {
    func fetchFoodDetails() {
        
    }
}
