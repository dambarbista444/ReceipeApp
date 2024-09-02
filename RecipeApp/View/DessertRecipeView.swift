//
//  DessertRecipeView.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/24/24.
//

import SwiftUI

struct DessertRecipeView: View {
    @StateObject var viewModel: DessertRecipeViewModel
    
    @State private var presentDetailsView = false
    @State private var selectedMealId = ""
    
    var searchText: String
    
    init(searchText: String) {
        _viewModel = StateObject(wrappedValue: DessertRecipeViewModel())
        self.searchText = searchText
    }
    
    var filteredmeals: [Meal] {
        if searchText.isEmpty {
            return viewModel.meals
        } else {
            return viewModel.meals.filter { $0.mealName?.localizedCaseInsensitiveContains(searchText) == true }
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView {
                        Text(LocalizedString.loadingText)
                    }
                case .success:
                    setupDessertListView()
                case .failure:
                    Text(LocalizedString.serviceErrorMessage)
                }
            }
            .task {
                await viewModel.getDessertList()
            }
            
        }
    }
    
    func setupDessertListView() -> some View {
        VStack(alignment: .leading) {
            ForEach(filteredmeals, id: \.self) { meal in
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemBackground))
                        .cornerRadius(15)
                        .frame(height: 100)
                        .shadow(radius: 2)
                    
                    HStack(spacing: 15) {
                        if let imageURL = viewModel.imageUrl(for: meal) {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .padding(.leading, 10)
                            } placeholder: {
                                ZStack {
                                    Color.gray
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                    ProgressView()
                                }
                                .padding(.leading, 10)
                            }
                        }
                        
                        Text(meal.mealName ?? "")
                        Spacer()
                    }
                }
                .padding([.horizontal, .top], 5)
                .onTapGesture {
                    selectedMealId = meal.mealId ?? ""
                    presentDetailsView = true
                }
            }
        }
        .fullScreenCover(isPresented: $presentDetailsView, content: {
            DessertRecipeDetailsView(mealId: $selectedMealId)
        })
    }
}
#Preview {
    DessertRecipeView(searchText: "")
}
