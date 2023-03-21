//
//  AppAlert.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-11-30.
//

import Foundation
import UIKit

class AppAlert: NSObject {
    
    //Singleton class
    static let shared = AppAlert()
    
    //MARK: - Delegate
    
    var onTapAction : ((Int)->Void)?
    
    //Simple Alert view
    public func simpleAlert(view: UIViewController, title: String?, message: String?){
        ToastManager.show(title: title ?? "", state: .error)
    }
    
    //Simple Alert view with button one
    public func simpleAlert(view: UIViewController, title: String, message: String, buttonTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //okButton Action
        let okButton = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.onTapAction?(0)
        }
        alert.addAction(okButton)
        view.present(alert, animated: true, completion: nil)
    }
    
    //Simple Alert view with two button
    public func simpleAlert(view: UIViewController, title: String, message: String, buttonOneTitle: String, buttonTwoTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //Button One Action
        let buttonOne = UIAlertAction(title: buttonOneTitle, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.onTapAction?(0)
        }
        
        //Button Two Action
        let buttonTwo = UIAlertAction(title: buttonTwoTitle, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            self.onTapAction?(1)
        }
        alert.addAction(buttonOne)
        alert.addAction(buttonTwo)
        view.present(alert, animated: true, completion: nil)
    }
    
}
