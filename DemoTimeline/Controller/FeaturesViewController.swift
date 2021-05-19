//
//  FeaturesViewController.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class FeaturesViewController: UIViewController {

    @IBOutlet weak var featuresCollectionView: UICollectionView!
    @IBOutlet weak var featuresPageControl: UIPageControl!
    
    let imageArray: [UIImage?] = [
        UIImage(named: "Image_1"),
        UIImage(named: "Image_2"),
        UIImage(named: "Image_3"),
        UIImage(named: "Image_4"),
        UIImage(named: "Image_5"),
    ]
    
    var currentPage = 0 {
        didSet {
            featuresPageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // PageControl Setup
        featuresPageControl.numberOfPages = imageArray.count
        
        // Register nib file
        let featuresCollectionViewCellNib = UINib(nibName: "FeaturesCollectionViewCell", bundle: Bundle(for: FeaturesCollectionViewCell.self))
        featuresCollectionView.register(featuresCollectionViewCellNib, forCellWithReuseIdentifier: "FeaturesCollectionViewCell")
        
        // CollectionView Setup
        featuresCollectionView.isPagingEnabled = true
        featuresCollectionView.showsHorizontalScrollIndicator = false
        featuresCollectionView.backgroundColor = .clear
        featuresCollectionView.delegate = self
        featuresCollectionView.dataSource = self
    }
    
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: featuresCollectionView.contentOffset, size: featuresCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = featuresCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        
        return currentPage
    }
    
}

extension FeaturesViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

extension FeaturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = featuresCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesCollectionViewCell", for: indexPath) as? FeaturesCollectionViewCell else { return  UICollectionViewCell() }
        
        if let image = imageArray[indexPath.row] {
            cell.configure(image: image)
        }
        
        return cell
    }
}

extension FeaturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 180)
    }
}
