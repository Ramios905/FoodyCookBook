//
//  CoredataLayer.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import Foundation
import CoreData

class CoredataLayer {
    // Insert Fav data
    func insertFavMeal(mealObject : MealDetailViewModel) {
        let predicate = NSPredicate(format: "SELF.%@ == %@",KeyConstant.idMeal,mealObject.idMeal)
        let mealObj: FavMeal = PersistenceManager.shared.fetchData(FavMeal.self, predicate).last ?? FavMeal(context: PersistenceManager.shared.context)
        mealObj.idMeal = mealObject.idMeal
        mealObj.strMeal = mealObject.strMeal
        mealObj.strInstructions = mealObject.strInstructions
        mealObj.strMealThumb = mealObject.strMealThumb
        mealObj.strYoutube = mealObject.strYoutube
        mealObj.strTags = mealObject.strTags
        PersistenceManager.shared.savePesistenceContext()
    }
    func deleteFavMeal(id : String) {
        let predicate = NSPredicate(format: "SELF.%@ == %@",KeyConstant.idMeal,id)
        PersistenceManager.shared.deleteRecords(FavMeal.self, search: predicate)
    }
    func isFavMeal(id : String) -> Bool {
        let predicate = NSPredicate(format: "SELF.%@ == %@",KeyConstant.idMeal,id)
        let mealObj: FavMeal? = PersistenceManager.shared.fetchData(FavMeal.self, predicate).last
        return mealObj == nil ? false : true
    }
    
    func getAllFavMeals() -> [FavMeal] {
        return PersistenceManager.shared.fetchData(FavMeal.self, nil)
    }
}
