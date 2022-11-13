//
//  FoodDetailView.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import SwiftUI

struct FoodDetailView: View {
    
    @StateObject var viewModel: FoodDetailViewModel
    
    init(viewModel: FoodDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                viewModel.onAppearAction()
            }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(viewModel: .init(id: 1))
    }
}
