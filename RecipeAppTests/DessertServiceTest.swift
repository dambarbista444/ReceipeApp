//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Dambar Bista on 8/31/24.
//

import XCTest
@testable import RecipeApp

final class DessertServiceTest: XCTestCase {
    var meal: Meal!
    var mealDetails: MealDetails!
    
    
    override func setUp() {
        super.setUp()
         meal = Meal(mealName: "Apam balik", mealImage: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", mealId: "53049")
        
        let ingredientes: [Ingredient] = [
            Ingredient(name: "Flour", measure: "1600g"),
            Ingredient(name: "Eggs", measure: "2"),
            Ingredient(name: "Salt", measure: "1/2tsp"),
            Ingredient(name: "Peanut", measure: "3 tsp"),
            ]
            
        mealDetails = MealDetails(idMeal: "53049", strMeal: "Apam balik", strInstructions: "some instruction", ingredients: ingredientes)
    }
    
    override func tearDown() {
        super.tearDown()
        meal = nil
        mealDetails = nil
    }
    
    
    func testMealProperties() {
        XCTAssertEqual(meal.mealName, "Apam balik")
        XCTAssertEqual(meal.mealImage, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        XCTAssertEqual(meal.mealId, "53049")
    }
    
    func testMealDetailsProperties() {
        XCTAssertEqual(mealDetails.strMeal, "Apam balik")
        XCTAssertEqual(mealDetails.idMeal,"53049")
        XCTAssertEqual(mealDetails.strInstructions, "some instruction")
        XCTAssertEqual(mealDetails.ingredients?[0].name, "Flour")
        XCTAssertEqual(mealDetails.ingredients?[1].name, "Eggs")
        XCTAssertEqual(mealDetails.ingredients?[0].measure, "1600g")
        XCTAssertEqual(mealDetails.ingredients?[1].measure, "2")
    }
}
