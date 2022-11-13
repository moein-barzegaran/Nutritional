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
    
    init(id: Int) {
        self.id = id
        print(id)
    }
}
