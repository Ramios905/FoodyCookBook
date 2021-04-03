//
//  MUtility.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import Foundation
import Kingfisher

class FoodUtility : NSObject{
    
    func loadImageWithUrl(imageVW : UIImageView,urlStr: String,completion:@escaping(Int)->()) {
        imageVW.kf.setImage(with: (URL(string: urlStr)), placeholder:UIImage(named: "placeHolder"), options: nil) { (result) in
            completion(1)
        }
    }
}
