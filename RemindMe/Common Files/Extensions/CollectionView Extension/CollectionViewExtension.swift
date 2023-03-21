//
//  CollectionViewExtension.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-11-30.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(nibName: String) {
        let Nib = UINib(nibName: nibName, bundle: nil)
        register(Nib, forCellWithReuseIdentifier: nibName)
    }
    
    func reloadInMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func setBackView(imageName:String,message:String)  {
        let imageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(named: imageName)
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        let _: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = .lightGray
            label.text = message
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        self.backgroundView = imageView
        
        imageView.centerXAnchor.constraint(equalToSystemSpacingAfter: self.centerXAnchor, multiplier: 1.0).isActive = true
        imageView.centerYAnchor.constraint(equalToSystemSpacingBelow: self.centerYAnchor, multiplier: 1.0).isActive = true
        DispatchQueue.main.async {
            imageView.setCornerRadius()
        }
    }
    
    func scrollToLastItem(animated : Bool) {
        
        let lastSection = self.numberOfSections - 1
        let lastRow = self.numberOfItems(inSection: lastSection)
        let indexPath = IndexPath(row: lastRow - 1, section: lastSection)
        self.scrollToItem(at: indexPath, at: .bottom, animated: animated)
    }
}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String! {
        
        let className = String(describing: self)
        return className
    }
}
