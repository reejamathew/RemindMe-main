//
//  SignUpController.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-01.
//

import UIKit

class SignUpController: UIViewController {
    
    @IBOutlet weak var outterView: UIView!
    @IBOutlet weak var createAccountLabel:UILabel!
    @IBOutlet weak var alreadyHaveAccLabel:UILabel!
    @IBOutlet weak var genderLabel:UILabel!
    @IBOutlet weak var signUpView:RoundedView!
    @IBOutlet weak var signInButton:UIButton!
    @IBOutlet weak var tcCheckBoxButton:UIButton!
    @IBOutlet weak var termsConditionTitleButton: UIButton!
    @IBOutlet weak var showPasswordButton:UIButton!
    @IBOutlet weak var maleButton:UIButton!
    @IBOutlet weak var femaleButton:UIButton!
    @IBOutlet weak var topView:UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var optionalLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    //Textfield
    @IBOutlet weak var firstNameTextfield:CustomTextField!
    @IBOutlet weak var lastNameTextfield:CustomTextField!
    @IBOutlet weak var emailTextfield:CustomTextField!
    @IBOutlet weak var passwordTextfield:CustomTextField!
    
    var presistentManager : PresistentManager!
    
    var isAcceptTerms = false {
        didSet {
            var image = UIImage()
            image = UIImage(named: isAcceptTerms ? StringConstant.squareFill : StringConstant.sqaureEmpty)!
            tcCheckBoxButton.setImage(image, for: .normal)
        }
    }
    
    var isMaleFemale:Bool = false { //true - male , false - female
        didSet {
            maleButton.setImage(UIImage(named: isMaleFemale ? StringConstant.circleFullImage : StringConstant.circleImage), for: .normal)
            femaleButton.setImage(UIImage(named: isMaleFemale ? StringConstant.circleImage : StringConstant.circleFullImage), for: .normal)
        }
    }
    
    var isShowPassword: Bool = false {
        didSet {
            passwordTextfield.isSecureTextEntry = isShowPassword
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.roundedTop(desiredCurve: topView.frame.height/3)
    }
}

//MARK: - Methods
extension SignUpController{
    
    private func initialLoads() {
        signUpView.addShadow(radius: 3.0, color: .lightGray)
        optionalLabel.textColor = .lightGray
        optionalLabel.text = StringConstant.optional.localized
        optionalLabel.font = .setCustomFont(name: .medium, size: .x12)
//        view.backgroundColor = .veryLightGray
        tcCheckBoxButton.addTarget(self, action: #selector(tapTermsCondtions(_:)), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(tapSignIn(_:)), for: .touchUpInside)
        showPasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        maleButton.addTarget(self, action: #selector(tapGender(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(tapGender(_:)), for: .touchUpInside)
        termsConditionTitleButton.addTarget(self, action: #selector(tapTCTitle(_:)), for: .touchUpInside)
        let signUp = UITapGestureRecognizer(target: self, action: #selector(tapSignUp))
        signUpView.addGestureRecognizer(signUp)
        maleButton.setImageTitle(spacing: 10)
        femaleButton.setImageTitle(spacing: 10)
        femaleButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
        femaleButton.imageView?.contentMode = .scaleAspectFit
        maleButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
        maleButton.imageView?.contentMode = .scaleAspectFit

        
        self.presistentManager = PresistentManager.shared
        setColors()
        localize()
        setDarkMode()
    }
    private func setDarkMode(){
        self.view.backgroundColor = .backgroundColor
        self.firstNameTextfield.textColor = .blackColor
        self.lastNameTextfield.textColor = .blackColor
        self.emailTextfield.textColor = .blackColor
        self.passwordTextfield.textColor = .blackColor
        self.createAccountLabel.textColor = .blackColor
        self.stackView.backgroundColor = .boxColor
        self.outterView.backgroundColor = .boxColor
      }
    private func setColors() {
        signUpView.centerImageView.imageTintColor(color1: .white)
        signUpView.backgroundColor = .appPrimaryColor
        termsConditionTitleButton.setTitleColor(.darkGray, for: .normal)
        alreadyHaveAccLabel.textColor = .darkGray
        createAccountLabel.textColor = .black
        signInButton.textColor(color: .appPrimaryColor)
    }
    private func localize() {
        createAccountLabel.text = StringConstant.createAccount.localized
        alreadyHaveAccLabel.text = StringConstant.alreadyHaveAcc.localized
        genderLabel.text = StringConstant.staticGender.localized
        maleButton.setTitle(StringConstant.male.localized, for: .normal)
        femaleButton.setTitle(StringConstant.female.localized, for: .normal)
        signInButton.setTitle(StringConstant.signIn.localized, for: .normal)
        termsConditionTitleButton.setTitle(StringConstant.acceptTermsCondition.localized, for: .normal)
        termsConditionTitleButton.titleLabel?.numberOfLines = 1;
        termsConditionTitleButton.titleLabel?.adjustsFontSizeToFitWidth = true;
        termsConditionTitleButton.titleLabel?.lineBreakMode = .byClipping;
        isAcceptTerms = false
        isShowPassword = true
        firstNameTextfield.autocapitalizationType = .words
        lastNameTextfield.autocapitalizationType = .words
        firstNameTextfield.placeholder = StringConstant.firstName.localized
        lastNameTextfield.placeholder = StringConstant.lastName.localized
        emailTextfield.placeholder = StringConstant.emailId.localized
        passwordTextfield.placeholder = StringConstant.password.localized
        maleButton.setImage(UIImage(named: StringConstant.circleImage), for: .normal)
        femaleButton.setImage(UIImage(named: StringConstant.circleImage), for: .normal)
        setFont()
        setTermsAndConditionAttributeText()
        
    }
    private func setFont() {
        createAccountLabel.font = .setCustomFont(name: .medium, size: .x20)
        alreadyHaveAccLabel.font = .setCustomFont(name: .medium, size: .x14)
        firstNameTextfield.font = .setCustomFont(name: .medium, size: .x16)
        lastNameTextfield.font = .setCustomFont(name: .medium, size: .x16)
        emailTextfield.font = .setCustomFont(name: .medium, size: .x16)
        genderLabel.font = .setCustomFont(name: .medium, size: .x16)
        passwordTextfield.font = .setCustomFont(name: .medium, size: .x16)
        signInButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
        termsConditionTitleButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
        maleButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
        femaleButton.titleLabel?.font = .setCustomFont(name: .medium, size: .x14)
    }
    func setTermsAndConditionAttributeText() {
        
        let text = (termsConditionTitleButton.titleLabel?.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "Terms and conditions")
        
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont.setCustomFont(name: .medium, size: .x14)]
        
        underlineAttriString.addAttributes(linkAttributes, range: range)
        termsConditionTitleButton.setAttributedTitle(underlineAttriString, for: .normal)
    }
    private func validation() -> Bool {
        guard let firstName = firstNameTextfield.text?.trimString(), !firstName.isEmpty else {
            firstNameTextfield.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.firstNameEmpty.localized, message: nil)
            return false
        }
        guard let lastName = lastNameTextfield.text?.trimString(),  !(lastName.isEmpty ) else {
            lastNameTextfield.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.lastNameEmpty.localized, message: nil)
            return false
        }
        guard let emailStr = emailTextfield.text?.trimString(), !(emailStr.isEmpty) else {
            emailTextfield.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.emailEmpty.localized, message: nil)
            return false
        }
        guard (emailStr.isValidEmail()) else {
            emailTextfield.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.validEmail.localized, message: nil)
            return false
        }
   
        guard let passwordStr = passwordTextfield.text?.trimString(), !passwordStr.isEmpty else {
            passwordTextfield.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.passwordEmpty.localized, message: nil)
            return false
        }
        guard passwordStr.isValidPassword else {
            passwordTextfield.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.passwordlength.localized, message: nil)
            return false
        }
        guard isAcceptTerms else {
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.notAcceptTC.localized, message: nil)
            return false
        }
        return true
    }
}

//MARK: - Button Action
extension SignUpController {
    
    @objc func tapSignIn(_ sender:UIButton) {
        self.view.endEditing()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.SignInController) as! SignInController
        vc.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapGender(_ sender:UIButton) {
        isMaleFemale = sender.tag == 0
    }
    
    @objc func tapTermsCondtions(_ sender:UIButton) {
        isAcceptTerms = !isAcceptTerms
    }
    
    @objc func tapTCTitle(_ sender:UIButton) {
        self.view.endEditing()
 
    }
    
    @objc func tapSignUp() {
        self.view.endEditing()
        signUpView.addPressAnimation()
        if validation() {
          let saveData =   self.saveData(firstName: firstNameTextfield.text!.trimString(), lastName: lastNameTextfield.text!.trimString(), emailId: emailTextfield.text!.trimString(), password: passwordTextfield.text!.trimString(), gender: isMaleFemale ? gender.male.rawValue : gender.female.rawValue)
            if saveData{
                let signinController = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.HomeController) as! HomeController
                signinController.navigationController?.setNavigationBarHidden(true, animated: false)
                self.navigationController?.pushViewController(signinController, animated: true)
            }else{
                AppAlert.shared.simpleAlert(view: self, title: StringConstant.signUpError.localized, message: StringConstant.signUpError.localized)
            }
            
        }
    }
    
    @objc func showPassword() {
        isShowPassword = !isShowPassword
    }
    
}

//MARK: - Textfield delegate

extension SignUpController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if textField == passwordTextfield && (textField.text?.count ?? 0) > 19 && !string.isEmpty  {
            return false
        }
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        return true
    }
}

//MARK: - CoreData Methods

extension SignUpController {
    private func saveData(firstName:String,lastName:String,emailId:String,password:String,gender:String?) -> Bool{
        let users = presistentManager.fetch(User.self)
        if users.count > 0{
            let existingUser = users.filter({$0.email == emailId})
            if existingUser.count > 0{
                return false
            }else{
                self.saveDefaults(emailId: emailId)
                let saveUser = User(context: presistentManager.context)
                saveUser.firstName = firstName
                saveUser.lastName = lastName
                saveUser.email = emailId
                saveUser.password = password
                saveUser.gender = gender
                return presistentManager.save()
            
            }
        }else{
            self.saveDefaults(emailId: emailId)
            let saveUser = User(context: presistentManager.context)
            saveUser.firstName = firstName
            saveUser.lastName = lastName
            saveUser.email = emailId
            saveUser.password = password
            saveUser.gender = gender
            return presistentManager.save()
        
        }
    }
    
    private func saveDefaults(emailId:String){
        let defaults = UserDefaults.standard
        defaults.set(emailId, forKey: StringConstant.email)
        UserDefaults.standard.synchronize()
    }
}
