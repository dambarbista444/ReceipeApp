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
    let categories = [RecipeType.dessert.rawValue,
                      RecipeType.dinner.rawValue,
                      RecipeType.breakfast.rawValue,
                      RecipeType.snack.rawValue]
    
    @State var recipeType: RecipeType = .dessert
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(categories, id: \.self) { category in
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .frame(width: 110, height: 45)
                                .onTapGesture {
                                    if category == RecipeType.dessert.rawValue {
                                        recipeType = .dessert
                                    } else if category == RecipeType.dinner.rawValue {
                                        recipeType = .dinner
                                    } else if category == RecipeType.breakfast.rawValue {
                                        recipeType = .breakfast
                                    } else if category == RecipeType.snack.rawValue {
                                        recipeType = .snack
                                    }
                                }
                            
                            Text(category)
                        }
                    }
                }
                .padding([.leading, .top], 5)
                .padding(.bottom, 20)
            }
            
            // Display view/screen based user selection
            switch recipeType {
            case .dessert:
                DessertRecipeView()
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
    RecipeCategoriesView()
}
