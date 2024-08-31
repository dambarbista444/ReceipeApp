//
//  DesssertRecipeDetails.swift
//  FetchReceipeApp
//
//  Created by Dambar Bista on 8/25/24.
//

import Foundation

struct DessertRecipeDetails: Codable {
    let meals: [MealDetails]
}

struct MealDetails: Codable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let ingredients: [Ingredient]?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    init(idMeal: String? = nil, strMeal: String? = nil, strDrinkAlternate: String? = nil, strCategory: String? = nil, strArea: String? = nil, strInstructions: String? = nil, strMealThumb: String? = nil, strTags: String? = nil, strYoutube: String? = nil, ingredients: [Ingredient]? = nil, strSource: String? = nil, strImageSource: String? = nil, strCreativeCommonsConfirmed: String? = nil, dateModified: String? = nil) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strDrinkAlternate = strDrinkAlternate
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strTags = strTags
        self.strYoutube = strYoutube
        self.ingredients = ingredients
        self.strSource = strSource
        self.strImageSource = strImageSource
        self.strCreativeCommonsConfirmed = strCreativeCommonsConfirmed
        self.dateModified = dateModified
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decode(String.self, forKey: .strYoutube)
        strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
        
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicKeys.self)
        var ingredients: [Ingredient] = []
        
        /// Decode all keys and identify ingredients and measures
        for key in dynamicContainer.allKeys {
            if key.stringValue.starts(with: "strIngredient"),
               let ingredientName = try dynamicContainer.decodeIfPresent(String.self, forKey: key),
               !ingredientName.isEmpty {
                let measureKey = DynamicKeys(stringValue: key.stringValue.replacingOccurrences(of: "strIngredient", with: "strMeasure"))!
                if let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey), !measure.isEmpty {
                    ingredients.append(Ingredient(name: ingredientName, measure: measure))
                }
            }
        }
        
        self.ingredients = ingredients
    }
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube, strSource, strImageSource, strCreativeCommonsConfirmed, dateModified
    }
}

struct Ingredient: Codable {
    let name: String
    let measure: String
}

struct DynamicKeys: CodingKey {
    static let ingredient = "strIngredient"
    static let measure = "strMeasure"
    
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
    }
}
