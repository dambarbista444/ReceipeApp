//
//  DessertRecipeDetailsViewModel.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/25/24.
//

import Foundation

class DessertRecipeDetailsViewModel: ObservableObject {
    let dessertRecipeService = DessertRecipeService()
    
    @Published var showErrorMessage = false
    
    @Published var instructions = ""
    @Published var mealName = ""
    @Published var mealImage = ""
    @Published var mealId = ""
 
    // Ingredients
    @Published var ingredient1 = ""
    @Published var ingredient2 = ""
    @Published var ingredient3 = ""
    @Published var ingredient4 = ""
    @Published var ingredient5 = ""
    @Published var ingredient6 = ""
    @Published var ingredient7 = ""
    @Published var ingredient8 = ""
    @Published var ingredient9 = ""
    @Published var ingredient10 = ""
    @Published var ingredient11 = ""
    @Published var ingredient12 = ""
    @Published var ingredient13 = ""
    @Published var ingredient14 = ""
    @Published var ingredient15 = ""
    @Published var ingredient16 = ""
    @Published var ingredient17 = ""
    @Published var ingredient18 = ""
    @Published var ingredient19 = ""
    @Published var ingredient20 = ""
    
    // Measure
    @Published var measure1 = ""
    @Published var measure2 = ""
    @Published var measure3 = ""
    @Published var measure4 = ""
    @Published var measure5 = ""
    @Published var measure6 = ""
    @Published var measure7 = ""
    @Published var measure8 = ""
    @Published var measure9 = ""
    @Published var measure10 = ""
    @Published var measure11 = ""
    @Published var measure12 = ""
    @Published var measure13 = ""
    @Published var measure14 = ""
    @Published var measure15 = ""
    @Published var measure16 = ""
    @Published var measure17 = ""
    @Published var measure18 = ""
    @Published var measure19 = ""
    @Published var measure20 = ""
    
    func getDessertList() async   {
        do {
            let meals = try await dessertRecipeService.getDessertRecipesDetails(by: mealId)
            
            await MainActor.run() {
                for meal in meals {
                    instructions = meal.strInstructions ?? ""
                    mealName = meal.strMeal ?? ""
                    mealImage = meal.strMealThumb ?? ""
                    updateIngredients(from: meal)
                    updateMeasure(from: meal)
                }
            }
        } catch let error {
            await MainActor.run {
                showErrorMessage = true
                print("Unable to retrive dessert details \(error)")
            }
           
        }
    }
    
    func imageUrl(for imageURL: String) -> URL? {
        if let url = URL(string: imageURL) {
            return url
        }
        return nil
    }
    
    func updateIngredients(from mealDetails: MealDetails) {
        ingredient1 = mealDetails.strIngredient1 ?? ""
        ingredient2 = mealDetails.strIngredient2 ?? ""
        ingredient3 = mealDetails.strIngredient3 ?? ""
        ingredient4 = mealDetails.strIngredient4 ?? ""
        ingredient5 = mealDetails.strIngredient5 ?? ""
        ingredient6 = mealDetails.strIngredient6 ?? ""
        ingredient7 = mealDetails.strIngredient7 ?? ""
        ingredient8 = mealDetails.strIngredient8 ?? ""
        ingredient9 = mealDetails.strIngredient9 ?? ""
        ingredient10 = mealDetails.strIngredient10 ?? ""
        ingredient11 = mealDetails.strIngredient11 ?? ""
        ingredient12 = mealDetails.strIngredient12 ?? ""
        ingredient13 = mealDetails.strIngredient13 ?? ""
        ingredient14 = mealDetails.strIngredient14 ?? ""
        ingredient15 = mealDetails.strIngredient15 ?? ""
        ingredient16 = mealDetails.strIngredient16 ?? ""
        ingredient17 = mealDetails.strIngredient17 ?? ""
        ingredient18 = mealDetails.strIngredient18 ?? ""
        ingredient19 = mealDetails.strIngredient19 ?? ""
        ingredient20 = mealDetails.strIngredient20 ?? ""
    }
    
    func updateMeasure(from mealDetails: MealDetails) {
        measure1 = mealDetails.strMeasure1 ?? ""
        measure2 = mealDetails.strMeasure2 ?? ""
        measure3 = mealDetails.strMeasure3 ?? ""
        measure4 = mealDetails.strMeasure4 ?? ""
        measure5 = mealDetails.strMeasure5 ?? ""
        measure6 = mealDetails.strMeasure6 ?? ""
        measure7 = mealDetails.strMeasure7 ?? ""
        measure8 = mealDetails.strMeasure8 ?? ""
        measure9 = mealDetails.strMeasure9 ?? ""
        measure10 = mealDetails.strMeasure10 ?? ""
        measure11 = mealDetails.strMeasure11 ?? ""
        measure12 = mealDetails.strMeasure12 ?? ""
        measure13 = mealDetails.strMeasure13 ?? ""
        measure14 = mealDetails.strMeasure14 ?? ""
        measure15 = mealDetails.strMeasure15 ?? ""
        measure16 = mealDetails.strMeasure16 ?? ""
        measure17 = mealDetails.strMeasure17 ?? ""
        measure18 = mealDetails.strMeasure18 ?? ""
        measure19 = mealDetails.strMeasure19 ?? ""
        measure20 = mealDetails.strMeasure20 ?? ""
    }
}
