//
//  ApiEndPoint.swift
//  FoodyCook​Book
//
//  Created by Ram on 3/04/21.
//

import Foundation
import Alamofire

protocol EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
    
}


enum EndPointItem {
    case getAllCategories
    case getAllSubCourses
    case getMealById
}


extension EndPointItem: EndPointType {

    // MARK: - Vars & Lets
    
    var headers: HTTPHeaders? {
        return nil
    }
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .stage: return "https://www.themealdb.com/api/json/"
        }
    }
    var version: String {
        return "v1/1/"
    }
    
    var path: String {
        switch self {
        case .getAllCategories:
            return "categories.php"
        case .getAllSubCourses:
            return "filter.php?i=\(FoodClient.shared.id)"
        case .getMealById:
            return "lookup.php?i=\(FoodClient.shared.id)"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var url: URL {
        switch self {
        default:
            print(URL(string: self.baseURL + self.version + self.path)!)
            return URL(string: self.baseURL + self.version + self.path)!
        }
    }
    
}
