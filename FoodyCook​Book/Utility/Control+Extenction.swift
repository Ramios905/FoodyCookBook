//
//  Control+Extenction.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import Foundation
import UIKit

enum StoryboardIdentifiers: String {
    case homeVC =  "HomeVC"
    case FavVC =  "AddLocVC"
    case subCourceVC =  "SubCourceVC"

    
}
enum StoryboardNames: String {
    case main = "Main"
}

extension UIViewController {
    func pushToController(with storyboardID:StoryboardIdentifiers, inStoryboard name:StoryboardNames){
        DispatchQueue.main.async {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: name.rawValue, bundle: nil)
            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier:storyboardID.rawValue)
            self.navigationController?.pushViewController(newViewcontroller, animated: true)
        }
    }
    func getController(fromStoryboard name:StoryboardNames,with storyboardID:StoryboardIdentifiers) -> UIViewController{
        let mainstoryboard:UIStoryboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier:storyboardID.rawValue)
        return newViewcontroller
    }
    @IBAction func tapBackToPreviousController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func hideTabBar() {
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    func showTabBar() {
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
