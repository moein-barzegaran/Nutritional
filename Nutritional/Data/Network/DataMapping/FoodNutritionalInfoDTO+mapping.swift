//
//  FoodNutritionalInfoDTO+mapping.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/9/22.
//

import Foundation

// MARK: - Data Transfer Object

struct FoodNutritionalInfoDTO: Decodable {
    let title: String
    let calories: Int
    let carbs: Float
    let protein: Float
    let fat: Float
    let saturatedfat: Float
    let unsaturatedfat: Float
    let fiber: Float
    let cholesterol: Float
    let sugar: Float
    let sodium: Float
    let potassium: Float
    let gramsperserving: Float
}

// MARK: - Mappings to Domain

extension FoodNutritionalInfoDTO {
    func toDomain() -> FoodNutritionalInfo {
        return .init(title: title,
                     calories: calories,
                     carbs: carbs,
                     protein: protein,
                     fat: fat,
                     saturatedfat: saturatedfat,
                     unsaturatedfat: unsaturatedfat,
                     fiber: fiber,
                     cholesterol: cholesterol,
                     sugar: sugar,
                     sodium: sodium,
                     potassium: potassium,
                     gramsperserving: gramsperserving)
    }
}
