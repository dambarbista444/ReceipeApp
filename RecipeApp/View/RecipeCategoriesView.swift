//
//  RecipeCategoriesView.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/26/24.
//

import SwiftUI

enum RecipeType: String {
    case dessert = "Dessert 🍰"
    case dinner = "Dinner 🥘"
    case breakfast = "Breakfast 🧇"
    case snack = "Snacks 🥨"
}

struct RecipeCategoriesView: View {
    var searchText: String
    
    let categories = [RecipeType.dessert,
                      RecipeType.dinner,
                      RecipeType.breakfast,
                      RecipeType.snack]
    
    @State var recipeType: RecipeType = .dessert
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .frame(width: 110, height: 45)
                                .onTapGesture {
                                    recipeType = categories[index]
                                }
                            
                            Text(categories[index].rawValue)
                        }
                    }
                }
                .padding([.leading, .top], 5)
                .padding(.bottom, 20)
            }
            
            // Display view/screen based user selection
            switch recipeType {
            case .dessert:
                DessertRecipeView(searchText: searchText)
            case .dinner:
                Text(RecipeType.dinner.rawValue)
                    .font(.title)
            case .breakfast:
                Text(RecipeType.breakfast.rawValue )
                    .font(.title)
            case .snack:
                Text(RecipeType.snack.rawValue)
                    .font(.title)
            }
        }
    }
}

#Preview {
    RecipeCategoriesView(searchText: "")
}
