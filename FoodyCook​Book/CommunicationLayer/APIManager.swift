//
//  ApiEndPoint.swift
//  FoodyCook​Book
//
//  Created by Ram on 3/04/21.
//

import Foundation
import Alamofire

enum NetworkEnvironment {
    case stage
}
/**Currently Not Using, maybe used in future*/
enum APIError: Error {
    case requestSuccess
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestSuccess: return "Request Success"
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
/************************************************/

class APIManager : NSObject {
    static let networkEnviroment: NetworkEnvironment = .stage
    static private var instance : APIManager {
        return APIManager()
    }
    private override init() {
        super.init()
    }
    static func sharedManager() -> APIManager {
        return instance
    }
    func callFetchSingleInstance<T>(type: EndPointType, params: Parameters? = nil, decodingType: T.Type, completion:@escaping  (Result<T, AFError>)->()) where T: Decodable {
        
        debugPrint("callGetLatestStatusInstance : \(params ?? ["":""])")
        
        debugPrint("callFetchSingleInstance URL : \(type.url)")
        
        AF.request(type.url,
                   method: type.httpMethod,
                   parameters: params,
                   encoding: type.encoding,
                   headers: type.headers)
            .validate(statusCode: 200...205)
            .responseJSON { data in
                switch data.result {
                case .success(_):
                    if let jsonData = data.data {
                        do{
                            guard let test_data = data.value else { return }
                            let test_data1 = test_data as! NSDictionary
                            debugPrint("\(test_data1)")
                            let genericResult =  try JSONDecoder().decode(T.self, from: jsonData)
                            
                            completion(.success(genericResult))
                        } catch let jsonErr{
                            
                            debugPrint(jsonErr)
                            debugPrint(jsonErr.localizedDescription as Any)
                        }
                    }
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
        }
    }
    
    
}
