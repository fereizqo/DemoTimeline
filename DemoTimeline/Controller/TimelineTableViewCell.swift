//
//  TimelineTableViewCell.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    var countRowSection: (row: Int, section:Int)?
    var currentIndexPath = IndexPath()
    let offsetTimeline: CGFloat = 40.0
    let circleRadius: CGFloat = 5.0

    @IBOutlet weak var typeCertificateLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var dateAwardedLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Create the circle
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: offsetTimeline, y: self.bounds.midY), radius: CGFloat(circleRadius), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        createCircle(path: circlePath)
        
        // Create the line
        let linePath = UIBezierPath()
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        startPoint = CGPoint(x: offsetTimeline, y: 0)
        linePath.move(to: startPoint)
        
        if let count = countRowSection {
            if currentIndexPath.row == count.row - 1 && currentIndexPath.section == count.section - 1 {
                endPoint = CGPoint(x: offsetTimeline, y: self.bounds.midY)
            } else {
                endPoint = CGPoint(x: offsetTimeline, y: self.bounds.maxY)
            }
            
        }
        linePath.addLine(to: endPoint)
        
        createLine(path: linePath)
    }
    
    func createCircle(path: UIBezierPath) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    func createLine(path: UIBezierPath) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2.0
        shapeLayer.lineCap = .butt
        shapeLayer.strokeColor = UIColor.systemGray2.cgColor
        self.layer.insertSublayer(shapeLayer, at: 1)
    }
}

extension TimelineTableViewCell {
    func configure(typeCertificate: String, courseName: String, dateAwarded: Date) {
        // Underline style
        let attributedCourseString = NSMutableAttributedString.init(string: typeCertificate)
        attributedCourseString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedCourseString.length))
        typeCertificateLabel.attributedText = attributedCourseString
        
        // Bold style
        courseNameLabel.font = UIFont.boldSystemFont(ofSize: courseNameLabel.font.pointSize)
        courseNameLabel.text = courseName
        
        // Gray color
        dateAwardedLabel.textColor = UIColor.darkGray
        dateAwardedLabel.text = "Awarded on: \(dateAwarded.toString())"
    }
}
