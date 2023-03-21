//
//  OnBoardPageViewControl.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-01.
//

import UIKit

struct WalKThroughData {
    var image: UIImage?
    var title: String?
    var description: String?
}

class OnBoardPageViewControl: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var onboardCollectionView: UICollectionView!
    
    var delegate: OnBoardPageViewDelegate!
    
    var dataSource: [WalKThroughData]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    
    }

    private func initialSetup() {
        Bundle.main.loadNibNamed(StringConstant.PageViewXib, owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
        collectionViewBasicSetup()
        
    }
    
    private func collectionViewBasicSetup() {
        dataSource = generateCustomObject()
        onboardCollectionView.register(UINib(nibName: StringConstant.PageViewCellXib, bundle: Bundle.main), forCellWithReuseIdentifier: StringConstant.PageControlCell)
        onboardCollectionView.dataSource = self
        onboardCollectionView.delegate = self
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = onboardCollectionView.contentOffset
        visibleRect.size = onboardCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = onboardCollectionView.indexPathForItem(at: visiblePoint) else { return }
        
        if let _ = delegate {
            delegate.visibleIndex(index: indexPath.row)
        }
    }
    
    private func generateCustomObject() -> [WalKThroughData] {
        var dataList = [WalKThroughData]()
        let remindMe = WalKThroughData(image: UIImage(named:StringConstant.walkthrough1), title: StringConstant.remindMe.localized, description: StringConstant.descriptionOne.localized)
        let workFlow = WalKThroughData(image: UIImage(named:StringConstant.walkthrough2), title:  StringConstant.workFlow.localized, description:  StringConstant.descriptionTwo.localized)
        let remindMeTwo = WalKThroughData(image:UIImage(named:StringConstant.walkthrough3), title:  StringConstant.remindMeTwo.localized, description:  StringConstant.descriptionThree.localized)


        dataList.append(remindMe)
        dataList.append(workFlow)
        dataList.append(remindMeTwo)

        return dataList
    }
}

extension OnBoardPageViewControl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         guard let data = dataSource else { return 0 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstant.PageControlCell, for: indexPath) as? OnBoardPageViewCell
            else { return UICollectionViewCell() }
        cell.setData(data: dataSource[indexPath.row])
        return cell
        
    }
    
    
}


extension OnBoardPageViewControl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
   
}
