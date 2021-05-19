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
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}

extension FeaturesCollectionViewCell {
    func configure(image: UIImage) {
        featuresImageView.image = image
    }
}
