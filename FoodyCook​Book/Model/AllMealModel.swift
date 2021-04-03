//
//  AllMealModel.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import Foundation

// MARK: - MealModel
struct MealModel: Codable {
    var categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    var idCategory, strCategory: String?
    var strCategoryThumb: String?
    var strCategoryDescription: String?
}
struct MainCourceModel {
    var name : String
    var imgStr : String
    var desStr : String
    var isFav : String
    var id : String
}



// MARK: - SubModel
struct SubModel: Codable {
    var meals: [SubMeal]?
}

// MARK: - SubMeal
struct SubMeal: Codable {
    var strMeal: String?
    var strMealThumb: String?
    var idMeal: String?
}



// MARK: - DetailMeal
struct DetailMeal: Codable {
    var meals: [Meal]?
}

// MARK: - Meal
struct Meal: Codable {
    var idMeal, strMeal, strDrinkAlternate, strCategory: String?
    var strArea, strInstructions: String?
    var strMealThumb: String?
    var strTags: String?
    var strYoutube: String?
}

