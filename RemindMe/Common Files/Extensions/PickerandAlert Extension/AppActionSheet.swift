//
//  AppActionSheet.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-02.
//

import Foundation
import UIKit

class AppActionSheet: NSObject {
    
    //Singleton class
    static let shared = AppActionSheet()
    
    //Delegate
    weak var delegate: AppActionSheetDelegate?
    
    var onTapAction : ((Int)->Void)?
    
    //Actionsheet with two button dynamic
    func showActionSheet(viewController: UIViewController,message: String? =  nil, buttonOne: String, buttonTwo: String? = nil, buttonThird: String? = nil) {
        
        let actionSheetController = UIAlertController(title: nil, message:message, preferredStyle: .actionSheet)
        
        //Cancel
        let cancelButtonAction = UIAlertAction(title: StringConstant.cancel.localized, style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelButtonAction)

        //Button One
        let buttonOneAction = UIAlertAction(title: buttonOne, style: .default) { action -> Void in
            self.onTapAction?(0)
            self.delegate?.actionSheetDelegate(tag: 0)
        }
        actionSheetController.addAction(buttonOneAction)
        
        if (buttonTwo != nil) {
            //Button Two
            let buttonTwoAction = UIAlertAction(title: buttonTwo, style: .default) { action -> Void in
                self.onTapAction?(1)
                self.delegate?.actionSheetDelegate(tag: 1)
            }
            actionSheetController.addAction(buttonTwoAction)
        }
        
        if (buttonThird != nil) {
            //Button Two
            let buttonThirdAction = UIAlertAction(title: buttonThird, style: .default) { action -> Void in
                self.onTapAction?(2)
                self.delegate?.actionSheetDelegate(tag: 2)
            }
            actionSheetController.addAction(buttonThirdAction)
        }
        
        viewController.present(actionSheetController, animated: true, completion: nil)
    }
}
