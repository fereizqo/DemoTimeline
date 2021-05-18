//
//  TimelineTableViewController.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    let testArray = [2020, 2019, 2018]
    let courseArray = [
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/08/2020"), courseName: "Swift Course 2", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/06/2020"), courseName: "Swift Course 1", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/08/2018"), courseName: "Python Course", typeCertificate: "Certificate of Completion"),
    ]
    
    var courseGrouped = [Int: [Course]]()
    var testGrouped = [[Course]]()
    
    fileprivate func groupingCourse() {
        courseGrouped = Dictionary(grouping: courseArray) { (element) -> Int in
            return element.dateAwarded.year
        }
        
        let sortedKeys = courseGrouped.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = courseGrouped[key]
            testGrouped.append(values ?? [])
        }
        
        print(testGrouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Grouping course by year
        groupingCourse()
        
        // Register tableview cell
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        let year = courseGrouped.keys
        
        return year.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        let course = Array(courseGrouped.keys)[section]
        return courseGrouped[course]?.count ?? 0
        
//        return testArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20.0, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = Array(courseGrouped.keys)[section].description
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        let linePath = UIBezierPath()
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        if section == 0 {
            startPoint = CGPoint(x: 20.0, y: 25)
        } else {
            startPoint = CGPoint(x: 20.0, y: 0)
        }
        
        endPoint = CGPoint(x: 20.0, y: 45)
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.lineWidth = 2.0
        shapeLayer.lineCap = .butt
        shapeLayer.strokeColor = UIColor.systemGray2.cgColor
        headerView.layer.insertSublayer(shapeLayer, at: 0)
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as! TimelineTableViewCell
        // Configure the cell
        cell.allRows = testArray.count
        cell.currentIndexPath = indexPath
        
        let courseByYear = Array(courseGrouped.keys)[indexPath.section]
        if let course = courseGrouped[courseByYear]?[indexPath.row] {
            // Underline style
            let attributedCourseString = NSMutableAttributedString.init(string: course.typeCertificate)
            attributedCourseString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedCourseString.length))
            cell.typeCertificateLabel.attributedText = attributedCourseString
            
            // Bold style
            cell.courseNameLabel.font = UIFont.boldSystemFont(ofSize: cell.courseNameLabel.font.pointSize)
            cell.courseNameLabel.text = course.courseName
            
            // Gray color
            cell.dateAwardedLabel.textColor = UIColor.darkGray
            cell.dateAwardedLabel.text = "Awarded on: ....."
        }

        return cell
    }
    
}
