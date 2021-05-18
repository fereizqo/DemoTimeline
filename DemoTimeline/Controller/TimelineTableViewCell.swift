//
//  TimelineTableViewCell.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    var allRows = Int()
    var currentIndexPath = IndexPath()
    let offSet: CGFloat = 20.0
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
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: offSet, y: self.bounds.midY), radius: CGFloat(circleRadius), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        createCircle(path: circlePath)
        
        // Create the line
        let linePath = UIBezierPath()
        
        var startPoint = CGPoint()
        if currentIndexPath.row == 0 {
            startPoint = CGPoint(x: offSet, y: self.bounds.midY)
        } else {
            startPoint = CGPoint(x: offSet, y: 0)
        }
        linePath.move(to: startPoint)
        
        var endPoint = CGPoint()
        if currentIndexPath.row == allRows-1 {
            endPoint = CGPoint(x: offSet, y: self.bounds.maxY)
        } else {
            endPoint = CGPoint(x: offSet, y: self.bounds.maxY)
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
