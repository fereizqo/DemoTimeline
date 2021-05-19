//
//  TestTableViewCell.swift
//  TestTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    var allRows = Int()
    var allSection = Int()
    var countRowSection: (row: Int, section:Int)?
    var currentIndexPath = IndexPath()
    let offSet: CGFloat = 40.0
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
        
        // Create the circle
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: offSet, y: self.bounds.midY), radius: CGFloat(circleRadius), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        createCircle(path: circlePath)
        
        // Create a line with dashed pattern
        let dashPath = UIBezierPath()
        var startPoint = CGPoint()

//        if currentIndexPath.row == 0 {
//            startPoint = CGPoint(x:offSet, y:self.bounds.midY)
//        } else {
//            startPoint = CGPoint(x:offSet, y:0)
//        }
        startPoint = CGPoint(x:offSet, y:0)
        dashPath.move(to: startPoint)

        var endPoint = CGPoint()

        print("IndexPath row: \(currentIndexPath.row) section: \(currentIndexPath.section)")
        if currentIndexPath.row == allRows - 1 && currentIndexPath.section == allSection - 1 {
            endPoint = CGPoint(x:offSet, y:self.bounds.midY)
        } else {
            endPoint = CGPoint(x:offSet, y:self.bounds.maxY)
        }

        dashPath.addLine(to: endPoint)

        dashPath.lineWidth = 2.0
        dashPath.lineCapStyle = .butt
        UIColor.systemGray2.set()
        dashPath.stroke()
        
        setNeedsDisplay()
    }
    
    func createCircle(path: UIBezierPath) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2.0
        self.layer.addSublayer(shapeLayer)
    }
}

extension TestTableViewCell {
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
