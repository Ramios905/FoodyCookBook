//
//  CoredataTestCases.swift
//  FoodyCook​BookTests
//
//  Created by Ram on 03/04/21.
//

import XCTest
@testable import FoodyCook_Book

class CoredataTestCases: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAllFavouritesIfNoValuesAdded() throws{
        
        XCTAssertTrue(CoredataLayer().getAllFavMeals().count == 0 ? true : false)
    }
    func testIsFavAdded() throws{
        
        XCTAssertTrue(CoredataLayer().isFavMeal(id: "123456") == false ? true : false)
    }
    
    func insertFav() throws{
        
        CoredataLayer().insertFavMeal(mealObject: .init(foodData: .init(idMeal: "123456", strMeal: "name", strInstructions: "instruction", strMealThumb: "image", strYoutube: "link", strTags: "tags")))
        
        XCTAssertTrue(CoredataLayer().isFavMeal(id: "123456") == true ? true : false)
    }
    
    func testDeleteFav() throws{
        CoredataLayer().insertFavMeal(mealObject: .init(foodData: .init(idMeal: "123456", strMeal: "name", strInstructions: "instruction", strMealThumb: "image", strYoutube: "link", strTags: "tags")))
        CoredataLayer().deleteFavMeal(id: "123456")
        XCTAssertTrue(CoredataLayer().getAllFavMeals().count == 0 ? true : false)
    }
    

}
