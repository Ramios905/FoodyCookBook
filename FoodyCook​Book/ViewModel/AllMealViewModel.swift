//
//  AllMealViewModel.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import Foundation
struct MealCourceViewModel {
    var name : String
    var imgStr : String
    var desStr : String
    var isFav : String
    var id : String
    
    init(mealData : MainCourceModel) {
        self.name = mealData.name
        self.imgStr = mealData.imgStr
        self.desStr = mealData.desStr
        self.isFav = mealData.isFav
        self.id = mealData.id
    }
}
class MealDataClass {
    
    func getMainCourseList(completion : @escaping(Int,[MealCourceViewModel]?)->()) {
    
        APIManager.sharedManager().callFetchSingleInstance(type: EndPointItem.getAllCategories, decodingType: MealModel.self) { (res) in
            switch res{
            case .success(let result):
                var mainlist = [MealCourceViewModel]()
                
                _ = result.categories!.map({ (object) in
                    
                    mainlist.append(.init(mealData: .init(name: object.strCategory ?? "No category", imgStr: object.strCategoryThumb ?? "", desStr: object.strCategoryDescription ?? "No category", isFav: "", id: "")))
                })
                completion(1,mainlist)
                
            case .failure(let error):
                completion(0,nil)
                print(error.errorDescription as Any)
            }

        }
        
    }
    func getSubCourseList(id : String,completion : @escaping(Int,[MealCourceViewModel]?)->()) {
    
        FoodClient.shared.id = id
        APIManager.sharedManager().callFetchSingleInstance(type: EndPointItem.getAllSubCourses, decodingType: SubModel.self) { (res) in
            switch res{
            case .success(let result):
                var sublist = [MealCourceViewModel]()
                
                if result.meals?.count ?? 0 > 0 {
                    _ = result.meals!.map({ (object) in
                        sublist.append(.init(mealData: .init(name: object.strMeal ?? "No name", imgStr: object.strMealThumb ?? "", desStr: "", isFav: "", id: object.idMeal ?? "0")))
                    })
                    completion(1,sublist)
                }else{
                    completion(0,sublist)
                }
                
                
            case .failure(let error):
                completion(0,nil)
                print(error.errorDescription as Any)
            }

        }
        
    }
    func getSubCourseDetails(object : MealCourceViewModel,completion : @escaping(Int,MealDetailViewModel?)->()) {
    
        FoodClient.shared.id = object.id
        APIManager.sharedManager().callFetchSingleInstance(type: EndPointItem.getMealById, decodingType: DetailMeal.self) { (res) in
            switch res{
            case .success(let result):
                var detailList = [MealDetailViewModel]()
                
                _ = result.meals?.map({ (object) in
                    detailList.append(.init(foodData: .init(idMeal: object.idMeal ?? "", strMeal: object.strMeal ?? "", strInstructions: object.strInstructions ?? "", strMealThumb: object.strMealThumb ?? "", strYoutube: object.strYoutube ?? "", strTags: object.strTags ?? "")))
                })
                if detailList.count == 0 {
                    detailList.append(.init(foodData: .init(idMeal: object.id , strMeal: object.name, strInstructions: object.desStr, strMealThumb: object.imgStr, strYoutube: "", strTags: "")))
                }
                    completion(1,detailList[0])
                
            case .failure(let error):
                completion(0,nil)
                print(error.errorDescription as Any)
            }

        }
        
    }

}
