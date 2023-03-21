//
//  RoundedView.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-11-30.
//

import UIKit

class RoundedView: UIView {
    
    var centerImageView: UIImageView!
    var centerImage: UIImage!
    let containerView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupView() {
        
        if let image = centerImage {
            
            centerImageView = UIImageView()
            centerImageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(centerImageView)
            
            centerImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
            centerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
            centerImageView.heightAnchor.constraint(equalToConstant: self.frame.height/2).isActive = true
            centerImageView.widthAnchor.constraint(equalToConstant: self.frame.height/2).isActive = true
            centerImageView.image = image
            
            
            DispatchQueue.main.async {
                self.setCornerRadius()
                self.applyCircleShadow()
            }
        }
    }
    
    @IBInspectable  var setCenterImage: UIImage! {
        didSet {
            centerImage = setCenterImage
            setupView()
        }
    }
}
