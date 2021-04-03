//
//  LocationAddViewModel.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import Foundation
struct MealDetailViewModel {
    var idMeal : String
    var strMeal : String
    var strInstructions : String
    var strMealThumb : String
    var strYoutube : String
    var strTags : String
    
    // Dependency Injection
    init(foodData : MealDetailModel) {
        self.idMeal = foodData.idMeal
        self.strMeal = foodData.strMeal
        self.strInstructions = foodData.strInstructions
        self.strMealThumb = foodData.strMealThumb
        self.strYoutube = foodData.strYoutube
        self.strTags = foodData.strTags
    }
}

