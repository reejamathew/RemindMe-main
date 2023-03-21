//
//  HomeController.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-02.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var logoutImg : UIImageView!
    @IBOutlet weak var noticeCollection : UICollectionView!
    @IBOutlet weak var addNewNote : RoundedView!
    
    var emailId:String?
    var noticesVal:[Notice]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialLoads()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noticesVal?.removeAll()
        self.getData()
    }

}

//MARK: - Methods
extension HomeController {
    private func intialLoads(){
        
        self.emailId = getEmail()
//        self.getData()
        addNewNote.addShadow(radius: 3.0, color: .lightGray)
        addNewNote.backgroundColor = .appPrimaryColor
        addNewNote.centerImageView.imageTintColor(color1: .white)
        let newNoteGesture = UITapGestureRecognizer(target: self, action: #selector(tapNewNote))
        addNewNote.addGestureRecognizer(newNoteGesture)
        logoutImg.isUserInteractionEnabled = true
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(tapLogout))
        logoutImg.addGestureRecognizer(logoutGesture)
        self.setupCollectionView()
    }
    private func setupCollectionView(){
        self.noticeCollection.delegate = self
        self.noticeCollection.dataSource = self
        self.noticeCollection.register(nibName: StringConstant.NoticeCell)
    }
    private func getData(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.dd_mm_yyyy_hh_mm_ss_a
        let notice = PresistentManager.shared.fetch(Notice.self)
        let noticeValuesforUser:[Notice] = notice.filter({$0.emailId == self.emailId})
        if noticeValuesforUser.count>0{
            for value in noticeValuesforUser{
                let formattedDate = dateFormatter.date(from: value.date ?? "")
                let currentDateString = dateFormatter.string(from: Date())
                let currentDate = dateFormatter.date(from: currentDateString)
                if formattedDate ?? Date() > currentDate ?? Date(){
                    noticesVal?.append(value)
                    
                }
            }
            self.noticeCollection.reloadData()
        }
        
    }
    private func getEmail()->String{
        
        if let email = UserDefaults.standard.value(forKey: StringConstant.email) as? String{
            return email
        }
        return ""
    }
}

//MARK: - Actions
extension HomeController{
    @objc  func tapNewNote(){
        addNewNote.addPressAnimation()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.CreateTaskController) as! CreateTaskController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapLogout(){
        
        self.deleteDefaults()
        self.logoutImg.addPressAnimation()
        UIApplication.shared.windows.last?.rootViewController?.navigationController?.popViewController(animated: true)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StringConstant.SplashController) as! SplashController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.isNavigationBarHidden = true
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

//MARK: - CollectionView delegate,datasource and Flow Layout

extension HomeController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return  noticesVal?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstant.NoticeCell, for: indexPath) as! NoticeCell
        let cellData = self.noticesVal?[indexPath.row]
        cell.noticeTitle.text = cellData?.title ?? ""
        cell.dateLbl.text = cellData?.date ?? ""
        cell.teacherNameLbl.text = "\(indexPath.item)"
        if cellData?.imagedata != nil{
            cell.noticeImg.image = UIImage(data: cellData?.imagedata ?? Data())
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 280)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StringConstant.ViewTasksController) as! ViewTasksController
        vc.notice = self.noticesVal?[indexPath.item] ?? Notice()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func deleteDefaults(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: StringConstant.loginVia)
        defaults.removeObject(forKey: StringConstant.email)
        UserDefaults.standard.synchronize()
    }
    
    
}


