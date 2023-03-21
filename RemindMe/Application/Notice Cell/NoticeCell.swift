
import UIKit

class NoticeCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var teacherNameLbl : UILabel!
    @IBOutlet weak var noticeTitle : UILabel!
    @IBOutlet weak var noticeImg : UIImageView!
    @IBOutlet weak var viewContent : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        self.setupView()
    }
    
    
    func setupView(){
        self.viewContent.setCorneredElevation(shadow: 2, corner: 20, color: .blackColor)
        self.dateLbl.font = .setCustomFont(name: .bold, size: .x12)
        self.teacherNameLbl.font = .setCustomFont(name: .medium, size: .x16)
        self.noticeTitle.font = .setCustomFont(name: .bold, size: .x16)
        self.noticeImg.addBlurView()
        self.viewContent.clipsToBounds = true
    }
    
}
