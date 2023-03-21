//
//  SplashController.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-11-30.
//

import UIKit

class SplashController: UIViewController {
    
    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var customPageControlView: OnBoardPageViewControl!
    @IBOutlet weak var pageIndexView: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.localize()
        design()
        self.intialLoads()
        customPageControlView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageIndexView.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }

}


extension SplashController {

    
    func localize() {
        signInButton.layer.cornerRadius = 16
        signUpButton.layer.cornerRadius = 16
        
       
        self.signInButton.setTitle( StringConstant.signIn.localized, for: .normal)
        self.signUpButton.setTitle( StringConstant.signUp.localized, for: .normal)
        self.welcome.text = StringConstant.welcome.localized
    }
    
    func intialLoads(){
        signInButton.addTarget(self, action: #selector(tapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(tapSignUp), for: .touchUpInside)
    }
    func design() {
    
        signUpButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x16)
        signInButton.titleLabel?.font = .setCustomFont(name: .bold, size: .x16)
        welcome.font = .setCustomFont(name: .bold, size: .x16)
        signUpButton.backgroundColor = .appPrimaryColor
        signInButton.setTitleColor(.appPrimaryColor, for: .normal)
        
       
    }
    
}

//MARK: - Action
extension SplashController{
    @objc func tapSignIn() {
        let signinController = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.SignInController) as! SignInController
        signinController.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.pushViewController(signinController, animated: true)

    }
    @objc func tapSignUp() {
        let signinController = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.SignUpController) as! SignUpController
        signinController.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.pushViewController(signinController, animated: true)

    }
}

extension SplashController: OnBoardPageViewDelegate {
    func visibleIndex(index: Int) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: UIView.AnimationOptions.transitionFlipFromBottom,
                       animations: { () -> Void in
                        
                      self.pageIndexView.currentPage = index
                        
        }, completion: { (finished) -> Void in
            
        })
    }
}





