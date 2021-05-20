//
//  TimelineTableViewCell.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    var allRows = Int()
    var allSection = Int()
    var countRowSection: (row: Int, section:Int)?
    var currentIndexPath = IndexPath()
    
    let offsetTimeline: CGFloat = 40.0
    let circleRadius: CGFloat = 5.0
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var typeCertificateLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var dateAwardedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Create the circle path
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: offsetTimeline, y: self.bounds.midY), radius: CGFloat(circleRadius), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        // Create layer for circle path
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 2.0
        
        // Add circle to cell view
        self.layer.addSublayer(circleLayer)
        
        // Create line for the timeline
        let linePath = UIBezierPath()
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        // The line start position at each row
        startPoint = CGPoint(x: offsetTimeline, y: 0)

        if currentIndexPath.row == allRows - 1 && currentIndexPath.section == allSection - 1 {
            // The line end position at last row and last section
            endPoint = CGPoint(x: offsetTimeline, y: self.bounds.midY)
        } else {
            // The line end position at other row and other section
            endPoint = CGPoint(x: offsetTimeline, y: self.bounds.maxY)
        }
        
        // Create the line path
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        // Fill the line path
        linePath.lineWidth = 2.0
        linePath.lineCapStyle = .butt
        UIColor.systemGray2.set()
        linePath.stroke()
        setNeedsDisplay()
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
