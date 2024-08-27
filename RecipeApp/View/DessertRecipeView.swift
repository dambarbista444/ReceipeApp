//
//  DessertRecipeView.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/24/24.
//

import SwiftUI

struct DessertRecipeView: View {
    @StateObject var viewModel =  DessertRecipeViewModel()
    
    @State var presentDetailsView = false
    @State var mealId = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                
                ForEach(viewModel.meals, id: \.self) { meal in
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(UIColor.systemBackground))
                            .cornerRadius(15)
                            .frame(height: 100)
                            .padding(.horizontal)
                            .shadow(radius: 2)
                        
                        HStack(spacing: 15) {
                            if let imageURL = viewModel.imageUrl(for: meal) {
                                AsyncImage(url: imageURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                        .padding(.leading, 30)
                                } placeholder: {
                                    ZStack {
                                        Color.gray
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(10)
                                        ProgressView()
                                    }
                                    .padding(.leading, 30)
                                }
                            }
                            
                            Text(meal.mealName ?? "")
                            Spacer()
                        }
                        .fullScreenCover(isPresented: $presentDetailsView, content: {
                            DessertRecipeDetailsView(mealId: $mealId)
                        })
                    }
                    .onTapGesture {
                        presentDetailsView = true
                        mealId = meal.mealId ?? ""
                    }
                }
            }
            .task {
                await viewModel.getDessertList()
            }
        }
        .navigationTitle(LocalizedString.discoverTitleText)
    }
}

#Preview {
    DessertRecipeView()
}
