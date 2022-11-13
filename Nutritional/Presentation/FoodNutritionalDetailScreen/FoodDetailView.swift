//
//  FoodDetailView.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import SwiftUI

struct FoodDetailView: View {
    
    @State private var showMoreInfo = false
    @State private var animationAmount = 1.0
    @StateObject var viewModel: FoodDetailViewModel
    
    
    init(viewModel: FoodDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            if !viewModel.isLoading {
                VStack {
                    if showMoreInfo {
                        fullInformationView
                    } else {
                        lessInformationView
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            self.showMoreInfo.toggle()
                        }
                        
                    } label: {
                        Text(showMoreInfo ? "Less info" : "More Info")
                            .frame(maxWidth: .infinity)
                            .font(.system(.title, weight: .light))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(viewModel.isLoading ? .gray : .black)
                            )
                            .padding()
                    }
                    
                }
                .scaleEffect(animationAmount)
                .animation(.easeInOut, value: animationAmount)
                .navigationTitle("Nutritional Info")
                
            } else {
                ProgressView()
                    .scaleEffect(2)
                    .onAppear {
                        viewModel.onAppearAction()
                    }
            }
            
        }
    }
    
    // MARK: less information view
    var lessInformationView: some View {
        VStack {
            VStack {
                Text(viewModel.foodTitle)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.bottom, 12)
                    .font(.system(.body, weight: .bold))
                    .frame(width: 120)
                
                Text(viewModel.calories)
                    .font(.system(size: 55))
                    .foregroundColor(.white)
                
                Text("Calories per serving")
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 25)
            }
            .padding(50)
            .background(
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.orangeLight, .orangeExtreme]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            )
            .padding(.top, 40)
            
            HStack(spacing: 15) {
                VStack {
                    Text("CARBS")
                    Divider()
                        .frame(width: 70)
                    Text("\(viewModel.carbs)%")
                }
                
                VStack {
                    Text("PROTEIN")
                    Divider()
                        .frame(width: 70)
                    Text("\(viewModel.protein)%")
                }
                
                VStack {
                    Text("FAT")
                    Divider()
                        .frame(width: 70)
                    Text("\(viewModel.fat)%")
                }
            }
            .padding(.top, 20)
        }
    }
    
    // MARK: full information view...
    var fullInformationView: some View {
        VStack {
            VStack {
                Text(viewModel.foodTitle)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .font(.system(.title, weight: .bold))
                
                HStack {
                    Text("Calories per serving")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Text(viewModel.calories)
                        .font(.system(size: 55))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.orangeLight, .orangeExtreme]), startPoint: .top, endPoint: .bottom)
                    )
            )
            .padding()
            
            ScrollView {
                ForEach(Array(viewModel.listDataSource.enumerated()), id:\.offset) { index, item in
                    HStack {
                        Text(item.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(item.value) %")
                            .font(.system(.body, weight: .bold))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                    if index < viewModel.listDataSource.count - 1 {
                        Divider()
                    }
                }
                .padding()
            }
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(viewModel: .init(id: 1))
    }
}
