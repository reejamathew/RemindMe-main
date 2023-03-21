//
//  ViewControllerExtensions.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-02.
//

import Foundation
import UIKit
import AVKit

private var imageCompletion : ((UIImage?)->())?

extension UIViewController {
    
    //MARK:- Show Image Selection Action Sheet
    
    func showImage(with completion : @escaping ((UIImage?)->())){  //isRemoveNeed - used to remove photo in profile

        AppActionSheet.shared.showActionSheet(viewController: self,message: StringConstant.choosePicture.localized, buttonOne: StringConstant.openCamera.localized, buttonTwo: StringConstant.openGallery.localized)
        imageCompletion = completion
        AppActionSheet.shared.onTapAction = { [weak self] tag in
            guard let self = self else {
                return
            }
            if tag == 0 {
                self.checkCameraPermission(source: .camera)
            }else if tag == 1 {
                self.checkCameraPermission(source: .photoLibrary)
            }
        }
    }
    
    private func checkCameraPermission(source : UIImagePickerController.SourceType) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch (cameraAuthorizationStatus){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.chooseImage(with: source)
                    }else {
                        ToastManager.show(title: StringConstant.cameraPermission.localized, state: .warning)
                    }
                }
            }
        case .restricted, .denied:
            ToastManager.show(title: StringConstant.cameraPermission.localized, state: .warning)
        case .authorized:
            self.chooseImage(with: source)
        default:
            ToastManager.show(title: StringConstant.cameraPermission.localized, state: .warning)
        }
    }
    

    
    
    
    // MARK:- Show Image Picker
    
    private func chooseImage(with source : UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = source
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    // MARK: - Hide KeyBoard
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1

    }
    

    
    public func setNavigationTitle() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blackColor, NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x20)]
    }
    

    
    //Left navigation bar button action
    @objc func leftBarButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK:- UIImagePickerControllerDelegate

extension UIViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imageCompletion?(image)
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


//MARK:- UINavigationControllerDelegate

extension UIViewController: UINavigationControllerDelegate {
    
}
