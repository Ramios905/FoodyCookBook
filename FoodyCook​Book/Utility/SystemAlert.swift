//
//  SystemAlert.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import Foundation
import UIKit
import SVProgressHUD

enum SystemAlertType : String {
    case okAlert = "Ok"
    case cancelAlert = "Cancel"
}

var alertController : UIAlertController?
public class SystemAlert {
    func basicNonActionAlert(withTitle title: String, message : String, alert:SystemAlertType){
        
        DispatchQueue.main.async {
            alertController?.dismiss(animated: true, completion: nil)
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: alert.rawValue, style: .default) { action in
            }
            OKAction.setValue(UIColor.systemGreen, forKey: "titleTextColor")
            alertController!.addAction(OKAction)
           
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alertController!, animated: true, completion: nil)
            }
            
        }
        
    }
    func basicActionAlert(withTitle title: String, message : String, actions:[SystemAlertType],  handler: @escaping (SystemAlertType) -> ()){
        removeLoader()
        DispatchQueue.main.async {
           
            //alertController?.dismiss(animated: true, completion: nil)
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for action in actions {
                let actionButton = UIAlertAction(title: action.rawValue, style: .default) { alertAction in
                    handler(action)
                }
                actionButton.setValue(UIColor.init(named: "AppThemeColorPrimary"), forKey:"titleTextColor")
                alertController!.addAction(actionButton)
            }
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                // topController should now be your topmost view controller
                topController.present(alertController!, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func removeAlert(){
        alertController?.dismiss(animated: true, completion: nil)
    }
    
    func showLoading() {
        removeLoader()

       DispatchQueue.main.async {
            SVProgressHUD.setRingThickness(3.0)
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.show()
        }
        
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }

    
}


