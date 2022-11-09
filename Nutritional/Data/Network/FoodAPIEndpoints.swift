//
//  FoodAPIEndpoints.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/9/22.
//

import Foundation

struct FoodAPIEndpoints {
    
    static func geFoodNutritionalInfo(with requestDTO: FoodRequestDTO) -> Endpoint<GeneralResponseDTO<FoodNutritionalInfoDTO>> {
        
        return Endpoint(path: "v2/foodipedia/codetest",
                        method: .get,
                        queryParametersEncodable: requestDTO)
    }
}
