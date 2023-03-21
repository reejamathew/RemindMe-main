//
//  CommonDelegate.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-01.
//

import Foundation

protocol OnBoardPageViewDelegate {
    
    func visibleIndex(index:Int)
}

@objc protocol AppActionSheetDelegate {
    
    //Button One Action
    func actionSheetDelegate(tag: Int) //tag - 0 : button one tag - 1 : button two
    
}
