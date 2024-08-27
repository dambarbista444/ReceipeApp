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
    @Published var mealDetails: MealDetails?
    
    @Published var instructions = ""
    @Published var mealName = ""
    @Published var mealImage = ""
    @Published var mealId = ""
    
    func getDessertList() async   {
        do {
            let meals = try await dessertRecipeService.getDessertRecipesDetails(by: mealId)
            
            await MainActor.run() {
                for meal in meals {
                    mealDetails = meal
                    instructions = meal.strInstructions ?? ""
                    mealName = meal.strMeal ?? ""
                    mealImage = meal.strMealThumb ?? ""
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
    
    func getIngredientsWithMeasures() -> [(String, String)] {
        guard let mealDetails = mealDetails else { return [] }
        
        return [
            (mealDetails.strIngredient1 ?? "", mealDetails.strMeasure1 ?? ""),
            (mealDetails.strIngredient2 ?? "", mealDetails.strMeasure2 ?? ""),
            (mealDetails.strIngredient3 ?? "", mealDetails.strMeasure3 ?? ""),
            (mealDetails.strIngredient4 ?? "", mealDetails.strMeasure4 ?? ""),
            (mealDetails.strIngredient5 ?? "", mealDetails.strMeasure5 ?? ""),
            (mealDetails.strIngredient6 ?? "", mealDetails.strMeasure6 ?? ""),
            (mealDetails.strIngredient7 ?? "", mealDetails.strMeasure7 ?? ""),
            (mealDetails.strIngredient8 ?? "", mealDetails.strMeasure8 ?? ""),
            (mealDetails.strIngredient9 ?? "", mealDetails.strMeasure9 ?? ""),
            (mealDetails.strIngredient10 ?? "", mealDetails.strMeasure10 ?? ""),
            (mealDetails.strIngredient11 ?? "", mealDetails.strMeasure11 ?? ""),
            (mealDetails.strIngredient12 ?? "", mealDetails.strMeasure12 ?? ""),
            (mealDetails.strIngredient13 ?? "", mealDetails.strMeasure13 ?? ""),
            (mealDetails.strIngredient14 ?? "", mealDetails.strMeasure14 ?? ""),
            (mealDetails.strIngredient15 ?? "", mealDetails.strMeasure15 ?? ""),
            (mealDetails.strIngredient16 ?? "", mealDetails.strMeasure16 ?? ""),
            (mealDetails.strIngredient17 ?? "", mealDetails.strMeasure17 ?? ""),
            (mealDetails.strIngredient18 ?? "", mealDetails.strMeasure18 ?? ""),
            (mealDetails.strIngredient19 ?? "", mealDetails.strMeasure19 ?? ""),
            (mealDetails.strIngredient20 ?? "", mealDetails.strMeasure20 ?? "")
        ]
    }
}
