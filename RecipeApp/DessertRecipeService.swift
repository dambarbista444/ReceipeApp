//
//  DesertRecipeService.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/24/24.
//

import Foundation

class DessertRecipeService {
    func getDessertRecipes() async throws -> [Meal] {
        guard let urlString = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: urlString)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Bad Server Response")
            throw URLError(.badServerResponse)
        }
        
        let desertRecipe = try JSONDecoder().decode(DessertRecipe.self, from: data)
        return desertRecipe.meals
    }
    
    func getDessertRecipesDetails(by mealId: String) async throws ->  [MealDetails] {
        guard let urlString = URL(string: "\("https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)")") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: urlString)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Bad Server Response")
            throw URLError(.badServerResponse)
        }
        
        let desertDetails = try JSONDecoder().decode(DessertRecipeDetails.self, from: data)
        let meals = desertDetails.meals
        return meals
    }
}
