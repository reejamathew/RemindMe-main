//
//  StringConstants.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-11-30.
//

import Foundation

enum StringConstant {
    
    static let appName = "RemindMe"
    //MARK: - String
    static let signIn = "Sign In"
    static let signUp = "Sign Up"
    static let welcome = "Welcome"
    static let descriptionOne = "I help you to Organise all your Tasks Under One Roof"
    static let descriptionTwo = "Add your Alerts wherever and whenever you want with just a few taps."
    static let descriptionThree = "View Your Tasks Individualy anytime or everytime you want"
    static let remindMe = "Remind Me"
    static let workFlow = "How do I work?"
    static let remindMeTwo = "Service Reminder"
    static let English = "English"
    static let Arabic = "Arabic"
    static let language = "Language"
    static let eye = "ic_eye"
    static let eyeOff = "ic_eye_off"
    static let mail = "ic_mail"
    static let imagePlaceHolder = "ImagePlaceHolder"
    static let email = "Email"
    static let dontHaveAcc = "Don't have an account"
    static let password = "Password"
    static let passwordlength = "Password Must have Atleast 6 Characters."
    static let loginVia = "Login"
    static let squareFill = "ic_square_fill"
    static let sqaureEmpty = "ic_square_empty"
    static let circleImage = "ic_circle"
    static let circleFullImage = "ic_circle_full"
    static let walkthrough1 = "Walkthrough1"
    static let walkthrough2 = "Walkthrough2"
    static let walkthrough3 = "Walkthrough3"
    static let optional = "(optional)"
    static let createAccount = "Create Account"
    static let alreadyHaveAcc = "Already have an account"
    static let acceptTermsCondition = "I accept the following Terms and conditions"
    static let male = "Male"
    static let female = "Female"
    static let firstName = "First Name"
    static let lastName = "Last Name"
    static let staticGender = "Gender"
    static let emailId = "Email Id"
    static let showTask = "Show Details"
    
    static let firstNameEmpty = "Enter First Name"
    static let lastNameEmpty = "Enter Last Name"
    static let notAcceptTC = "Please accept Terms and conditions"
    static let Submit = "Submit"
    static let addTask = "Add New Task"
    static let titleTask = "Title For The Task"
    static let taskNote = "Enter details about your Task"
    static let imgUpload = "Do you want to upload a Image?"
    static let datetoRemind = "Enter Deadline Date and Time"
    static let cancel = "Cancel"
    static let openCamera = "Open Camera"
    static let openGallery = "Open Gallery"
    static let choosePicture = "Choose your picture"
    static let cameraPermission = "Unable to open camera, Check your camera permission"
    
    //MARK: - Alerts
    static let sucess = "Success"
    static let error = "Error"
    static let signUpError = "Exisitng User! Please Login"
    static let signInError = "User Not Found! Please SignUp"
    static let somethingWentWrong = "Something Went Wrong Try Again"
    static let emailEmpty = "Enter Email Id"
    static let passwordEmpty = "Enter Password"
    static let validEmail = "Enter valid email id"
    static let enterTitle = "Enter Title for your notes"
    static let enterNotes = "Enter your content for notes"
    static let enterTime = "Select the time to remind You"
    
    
    //MARK: - CustomView
    static let PageViewXib = "OnBoardPageViewControl"
    static let PageViewCellXib = "OnBoardPageViewCell"
    static let PageControlCell = "PageControlCell"
    static let NoticeCell = "NoticeCell"
    
    //MARK: - Viewcontroller Identifier
    static let SplashController = "SplashController"
    static let SignInController = "SignInController"
    static let SignUpController = "SignUpController"
    static let HomeController = "HomeController"
    static let CreateTaskController = "CreateTaskController"
    static let ViewTasksController = "ViewTasksController"
}


struct DateFormat {
    
    static let yyyy_mm_dd_hh_mm_ss = "yyyy-MM-dd HH:mm:ss"
    static let yyyy_MM_dd_T_HH_mm_ss_SSSSSS_Z = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
    static let yyyy_mm_dd_hh_mm_ss_a = "yyyy-MM-dd HH:mm:ss"
    static let dd_mm_yyyy_hh_mm_ss = "dd-MM-yyyy HH:mm:ss"
    static let dd_mm_yyyy_hh_mm_ss_a = "dd-MM-yyyy hh:mm a"
    static let ddmmyyyy = "dd-MM-yyyy"
    static let ddMMMyy12 = "dd MMM yyyy, hh:mm a"
    static let ddMMMyy24 = "dd MMM yyyy, HH:mm:ss"
}


enum gender: String {
    case male = "MALE"
    case female = "FEMALE"
}
