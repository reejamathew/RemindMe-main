//
//  OnBoardPageViewCell.swift
//  RemindMe
//
//  Created by Sethuram Vijayakumar on 2022-12-01.
//

import UIKit

class OnBoardPageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data:WalKThroughData) {
        self.imageView.image = data.image
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
    }
}
