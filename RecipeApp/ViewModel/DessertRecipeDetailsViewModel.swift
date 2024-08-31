//
//  DessertRecipeDetailsViewModel.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/25/24.
//

import Foundation

class DessertRecipeDetailsViewModel: ObservableObject {
    @Published var showErrorMessage = false
    
    @Published var instructions = ""
    @Published var mealName = ""
    @Published var mealImage = ""
    @Published var mealId = ""
    @Published var ingredients: [Ingredient] = []
    
    init() {
        
    }
    
    @MainActor
    func getDessertList() async   {
        do {
            let mealDetails = try await DessertRecipeService.sharedInstance.getDessertRecipesDetails(by: mealId)
            
            for meal in mealDetails {
                instructions = meal.strInstructions ?? ""
                mealName = meal.strMeal ?? ""
                mealImage = meal.strMealThumb ?? ""
                
                if let ingredients = meal.ingredients {
                    self.ingredients = ingredients
                }
            }
        } catch let error {
            showErrorMessage = true
            print("Unable to retrive dessert details \(error)")
        }
    }
    
    func imageUrl(for imageURL: String) -> URL? {
        if let url = URL(string: imageURL) {
            return url
        }
        return nil
    }
}

