//
//  DesertRecipe.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/24/24.
//

import Foundation

struct DessertRecipe: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Hashable, Identifiable {
    let id = UUID()
    let mealName: String?
    let mealImage: String?
    let mealId: String?
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImage = "strMealThumb"
        case mealId = "idMeal"
    }
}
