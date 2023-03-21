//
//  SignInController.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-11-30.
//

import UIKit
var isDarkMode = false

class SignInController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var topView:UIView!
    @IBOutlet weak var mailView:UIView!
    @IBOutlet weak var mailTextFieldView:UIView!
    @IBOutlet weak var signInView:RoundedView!
    @IBOutlet weak var mailImage:UIImageView!
    @IBOutlet weak var signUpButton:UIButton!
    @IBOutlet weak var showPasswordButton:UIButton!
    @IBOutlet weak var dontHaveAccountLabel:UILabel!
    @IBOutlet weak var emailTextField:CustomTextField!
    @IBOutlet weak var passwordTextField:CustomTextField!
    @IBOutlet weak var loginViaLabel:UILabel!

    var presistentManager : PresistentManager!
    
    var isShowPassword:Bool = false {
        didSet {
            passwordTextField.isSecureTextEntry = isShowPassword
            showPasswordButton.setImage(UIImage(named: isShowPassword ? StringConstant.eyeOff : StringConstant.eye), for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        setDarkMode()
        
    }
    

}

//MARK: - Methods

extension SignInController {
    private func initialLoads(){
        signInView.addShadow(radius: 3.0, color: .lightGray)
        localize()
        setColors()
        let signinGuesture = UITapGestureRecognizer(target: self, action: #selector(tapSignIn))
        signInView.addGestureRecognizer(signinGuesture)
        signUpButton.addTarget(self, action: #selector(tapSignUp), for: .touchUpInside)
        showPasswordButton.addTarget(self, action: #selector(tapShowPassword), for: .touchUpInside)
        passwordTextField.textColor = .black
        self.mailImage.image = UIImage(named: StringConstant.mail)
        isShowPassword = true
        setFont()
        self.presistentManager = PresistentManager.shared
    }
    
    private func localize() {
        emailTextField.placeholder = StringConstant.email.localized
        signUpButton.setTitle(StringConstant.signUp.localized, for: .normal)
        dontHaveAccountLabel.text = StringConstant.dontHaveAcc.localized
        passwordTextField.placeholder = StringConstant.password.localized
        loginViaLabel.text = StringConstant.loginVia.localized
    }
    
    private func setColors() {
        dontHaveAccountLabel.textColor = .darkGray
        signUpButton.textColor(color: .appPrimaryColor)
        signInView.backgroundColor = .appPrimaryColor
        signInView.centerImageView.imageTintColor(color1: .white)
    }
    private func setFont() {
        dontHaveAccountLabel.font = .setCustomFont(name: .light, size: .x12)
        passwordTextField.font = .setCustomFont(name: .medium, size: .x14)
        emailTextField.font = .setCustomFont(name: .medium, size: .x14)
    }
    
    private func textfieldUIUpdate() {
        passwordTextField.text = String.empty
        emailTextField.text = String.empty
        self.view.endEditing()
        UIView.animate(withDuration: 0.3) {
               self.mailImage.imageTintColor(color1: .appPrimaryColor)
                self.mailView.backgroundColor = UIColor.appPrimaryColor.withAlphaComponent(0.1)
        }
    }
    private func validation() -> Bool {

            guard let emailStr = emailTextField.text?.trimString(), !emailStr.isEmpty else {
                emailTextField.becomeFirstResponder()
                AppAlert.shared.simpleAlert(view: self, title: StringConstant.emailEmpty.localized, message: nil)
                return false
            }
            guard emailStr.isValidEmail() else {
                emailTextField.becomeFirstResponder()
                AppAlert.shared.simpleAlert(view: self, title: StringConstant.validEmail.localized, message: nil)
                return false
            }
        
        guard let passwordStr = passwordTextField.text?.trimString(), !passwordStr.isEmpty else {
            passwordTextField.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.passwordEmpty.localized, message: nil)
            return false
        }
        guard passwordStr.isValidPassword else {
            passwordTextField.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.passwordlength.localized, message: nil)
            return false
        }
        return true
    }
    private func setDarkMode(){
        self.view.backgroundColor = .backgroundColor
        self.loginView.backgroundColor = .boxColor
        self.mailView.backgroundColor = .boxColor
        self.emailTextField.textColor = .blackColor
        self.passwordTextField.textColor = .blackColor
        self.loginViaLabel.textColor = .blackColor
        textfieldUIUpdate()
      }
}


//MARK: - Actions

extension SignInController {
    @objc func tapSignIn() {
        signInView.addPressAnimation()
        self.view.endEditing()
        if validation() {
            let checkUser:Bool = self.checkUser(emailId: emailTextField.text!.trimString(), password: passwordTextField.text!.trimString())
            if checkUser{
                self.saveDefaults(emailId: emailTextField.text!.trimString())
                self.saveLogin(login: 1)
                let signinController = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.HomeController) as! HomeController
                signinController.navigationController?.setNavigationBarHidden(true, animated: false)
                self.navigationController?.pushViewController(signinController, animated: true)
            }else{
                AppAlert.shared.simpleAlert(view: self, title: StringConstant.signInError.localized, message: StringConstant.signUpError.localized)
            }
        }
    }
    
    @objc func tapSignUp() {
        let signinController = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.SignUpController) as! SignUpController
        signinController.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.pushViewController(signinController, animated: true)

    }
    
    @objc func tapShowPassword() {
        isShowPassword = !isShowPassword
    }
}


//MARK: - TextField Delegate
extension SignInController: UITextFieldDelegate {
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        return true
    }
    
}


//MARK: - CoreData & UserDefault 

extension SignInController {
    private func checkUser(emailId:String,password:String) -> Bool{
        let users = presistentManager.fetch(User.self)
        if users.count > 0{
            let existingUser = users.filter({$0.email == emailId && $0.password == password})
            if existingUser.count > 0{
                self.saveDefaults(emailId: emailId)
                return true
            }
        }
        return false
    }
    
    private func saveDefaults(emailId:String){
        let defaults = UserDefaults.standard
        defaults.set(emailId, forKey: StringConstant.email)
        UserDefaults.standard.synchronize()
    }
    private func saveLogin(login:Int){
        let defaults = UserDefaults.standard
        defaults.set(login, forKey: StringConstant.loginVia)
        UserDefaults.standard.synchronize()
    }
}
