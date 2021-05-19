//
//  FeaturesCollectionViewCell.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 19/05/21.
//

import UIKit

class FeaturesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var featuresImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension FeaturesCollectionViewCell {
    func configure(image: UIImage) {
        featuresImageView.image = image
    }
}
