//
//  ViewTasksController.swift
//  RemindMe
//
//  Created by Srijan  on 2022-12-01.
//

import UIKit

class ViewTasksController: UIViewController {
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var backImg : UIImageView!
    
    @IBOutlet weak var titleTxt : UITextField!
    @IBOutlet weak var noticeTxt : UILabel!
    @IBOutlet weak var noticeImg : UIImageView!
    
    @IBOutlet weak var dateLbl : UITextField!
    
    var notice : Notice?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialLoads()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupData()
    }

}

extension ViewTasksController{
    private func intialLoads(){
        self.setupAction()
        self.setupView()
    }
    func setupAction(){
        self.backImg.isUserInteractionEnabled = true
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(tapBack))
        backImg.addGestureRecognizer(backGesture)
        self.titleTxt.text = StringConstant.showTask.localized
    }
    @objc func tapBack(){
        backImg.addPressAnimation()
        self.navigationController?.popViewController(animated: true)
    }
    func setupView(){
        [self.titleTxt,self.noticeTxt,self.noticeImg].forEach { (view) in
            view?.layer.cornerRadius = 15
        }
    }
    func setupData(){
            self.titleTxt.text = self.notice?.title ?? ""
            self.noticeTxt.text = self.notice?.notice ?? ""
            if self.notice?.imagedata != nil{
                self.noticeImg.image = UIImage(data: self.notice?.imagedata ?? Data())
            }else{
                self.noticeImg.image = UIImage(named: "notice")
            }
            self.dateLbl.text = self.notice?.date ?? ""
        
    }
}
