//
//  DessertRecipeViewModel.swift
//  RecipeApp
//
//  Created by Dambar Bista on 8/24/24.
//

import Foundation

class DessertRecipeViewModel: ObservableObject {
    @Published var meals = [Meal]()
   
    var showErrorMessage = false
    
    init() {
        
    }
    
    @MainActor
    func getDessertList() async   {
        do {
            let sortedMeals = try await DessertRecipeService.sharedInstance.getDessertRecipes().compactMap({ $0 }).sorted(by: { $0.mealName ?? "" < $1.mealName ?? "" })
            
            meals = sortedMeals
        } catch let error {
            // Handle Error here
            showErrorMessage = true
            print("Unable to retrive dessert \(error)")
        }
    }
    
    func imageUrl(for meal: Meal) -> URL? {
        if let urlString = meal.mealImage, let url = URL(string: urlString) {
            return url
        }
        return nil
    }
}
