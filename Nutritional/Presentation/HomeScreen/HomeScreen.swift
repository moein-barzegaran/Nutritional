//
//  HomeScreen.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import SwiftUI

enum HomeRoute: Hashable {
    case foodDetail(Int)
}

struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack{
            Button {
                viewModel.onTapMeAction()
            } label: {
                Circle()
                    .fill(.orange)
                    .frame(width: 100, height: 100)
                    .shadow(radius: 5)
                    .overlay(
                        Text("Tap Me!")
                            .font(.headline)
                            .foregroundColor(.white)
                    )
            }
            .navigationTitle("Let's start")
            .navigationDestination(isPresented: $viewModel.shouldShowFoodDetail) {
                FoodDetailView(viewModel: .init(id: viewModel.makeRandomId()))
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
