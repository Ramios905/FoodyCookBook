//
//  ApiClient.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import Foundation
@objc public class FoodClient: NSObject {
    
    /**
     Saving Ids instance
     - returns: FoodClient single instance
     */
    public override init() {
        //super.init()
    }
    @objc public static let shared = FoodClient()
    
    
    /// - Parameters:
    ///   - id:  id for type.
    public  var id: String = ""
    
}
