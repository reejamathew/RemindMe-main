//
//  CreateTaskController.swift
//  RemindMe
//
//  Created by Reeja Mathew on 2022-12-03.
//

import UIKit

class CreateTaskController: UIViewController {
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var backImg : UIImageView!
    @IBOutlet weak var titleTxt : UITextField!
    @IBOutlet weak var noticeTxt : UITextView!
    @IBOutlet weak var noticeImg : UIImageView!
    @IBOutlet weak var titleTxtLbl: UILabel!
    @IBOutlet weak var noticeTxtLbl: UILabel!
    @IBOutlet weak var ImgTxtLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var RemindDateLbl: UILabel!
    @IBOutlet weak var remindDateTxt: UITextField!
    
    
    var isImageUpload : Bool?
    var selectedDate:String?
    var imageData: Data?
    var presistentManager : PresistentManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialLoads()

    }

}

extension CreateTaskController {
    
    func intialLoads(){
        self.setupView()
        self.localize()
        self.setDesigns()
        backImg.isUserInteractionEnabled = true
        noticeImg.isUserInteractionEnabled = true
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(tapBack))
        backImg.addGestureRecognizer(backGesture)
        let imgAction = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        noticeImg.addGestureRecognizer(imgAction)
        self.submitBtn.addTarget(self, action: #selector(tapSubmit), for: .touchUpInside)
        remindDateTxt.delegate = self
        presistentManager = PresistentManager.shared
       
        
    }
    func setupView(){
        [self.titleTxt,self.noticeTxt,self.noticeImg,self.remindDateTxt,self.submitBtn].forEach { (view) in
            view?.layer.cornerRadius = 15
        }
        submitBtn.backgroundColor = .appPrimaryColor
        submitBtn.setTitleColor(.whiteColor, for: .normal)
       
    }
    func setDesigns(){
        submitBtn.setTitle(StringConstant.Submit.localized, for: .normal)
        titleLbl.font = .setCustomFont(name: .bold, size: .x16)
        titleTxtLbl.font = .setCustomFont(name: .bold, size: .x16)
        noticeTxtLbl.font = .setCustomFont(name: .bold, size: .x16)
        ImgTxtLbl.font  = .setCustomFont(name: .bold, size: .x16)
        RemindDateLbl.font = .setCustomFont(name: .bold, size: .x16)
    }
    func localize(){
        submitBtn.setTitle(StringConstant.Submit.localized, for: .normal)
        titleLbl.text = StringConstant.addTask.localized
        titleTxtLbl.text = StringConstant.titleTask.localized
        noticeTxtLbl.text = StringConstant.taskNote.localized
        ImgTxtLbl.text  = StringConstant.imgUpload.localized
        RemindDateLbl.text = StringConstant.datetoRemind.localized
    }
    private func validation() -> Bool {

            guard let titleStr = titleTxt.text?.trimString(), !titleStr.isEmpty else {
                titleTxt.becomeFirstResponder()
                AppAlert.shared.simpleAlert(view: self, title: StringConstant.emailEmpty.localized, message: nil)
                return false
            }
        guard let notesStr = noticeTxt.text?.trimString(), !notesStr.isEmpty else {
            noticeTxt.becomeFirstResponder()
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.enterNotes.localized, message: nil)
            return false
        }
        guard let timeStr = remindDateTxt.text?.trimString(), !timeStr.isEmpty else {
            AppAlert.shared.simpleAlert(view: self, title: StringConstant.enterTime.localized, message: nil)
            return false
        }
        
        return true
    }
}


extension CreateTaskController {
    @objc func tapBack(){
        backImg.addPressAnimation()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapSubmit(){
        if validation(){
            if saveData(title: self.titleTxt.text!.trimString(), noticeString: self.noticeTxt.text!.trimString(), image: self.imageData, dateVal: self.selectedDate, emailId: getEmail()){
                ToastManager.show(title: StringConstant.sucess.localized, state: .success)
                self.navigationController?.popViewController(animated: true)
            }else{
                AppAlert.shared.simpleAlert(view: self, title: StringConstant.somethingWentWrong.localized, message: "")
            }
        }
        
        
    }
    @objc func tapImage(){
        self.showImage(with: { (image) in
            self.noticeImg.layer.cornerRadius = 8
            self.noticeImg.image = image
            if  let selectedImageData =   image?.pngData(){
                self.imageData = selectedImageData
                
            }
        })
    }
}


extension CreateTaskController : UITextFieldDelegate{
   
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == remindDateTxt{
            PickerManager.shared.showDatePicker(selectedDate: "", minDate: Date()) { [weak self] (selectedDate) in
                guard let self = self else {
                    return
                }
                self.remindDateTxt.text = selectedDate
                self.selectedDate = selectedDate
               
            }
            return false
        }
        return true
    }
    
    
}


extension CreateTaskController {
    
    private func saveData(title:String,noticeString:String,image:Data?,dateVal:String?,emailId:String?) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.dd_mm_yyyy_hh_mm_ss_a
        guard let datetobeNotified = dateFormatter.date(from: dateVal ?? "") else { return false }
        NotificationsManager.shared.add(date: datetobeNotified, title: title, text: noticeString)
        let saveNotice = Notice(context: presistentManager.context)
        saveNotice.title = title
        saveNotice.notice = noticeString
        saveNotice.emailId = emailId
        saveNotice.date = dateVal
        saveNotice.imagedata = image

        return presistentManager.save()
    }
    
    private func getEmail()->String{
        
        if let email = UserDefaults.standard.value(forKey: StringConstant.email) as? String{
            return email
        }
        return ""
    }

}
