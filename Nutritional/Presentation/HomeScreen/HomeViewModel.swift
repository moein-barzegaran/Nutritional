//
//  HomeViewModel.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var shouldShowFoodDetail = false
    
    func onTapMeAction() {
        shouldShowFoodDetail = true
    }
    
    func makeRandomId() -> Int {
        Int.random(in: 0..<100)
    }
}
