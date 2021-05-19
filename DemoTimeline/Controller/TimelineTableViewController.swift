//
//  TimelineTableViewController.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    let offsetTimeline = 40.0
    let testArray = [2020, 2019, 2018]
    let courseArray = [
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/08/2020"), courseName: "Swift Course 2", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/06/2018"), courseName: "Swift Course 1", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/08/2014"), courseName: "Python Course", typeCertificate: "Certificate of Completion"),
    ]
    
    var courseGrouped = [Dictionary<Int, [Course]>.Element]()
    
    fileprivate func groupingCourse() {
        var coursesGrouped = Dictionary(grouping: courseArray) { (element) -> Int in
            return element.dateAwarded?.year ?? 0
        }
        
        let yearArray = Array(coursesGrouped.keys)
        let yearFilledArray = Array(yearArray.min()!...yearArray.max()!)
        
        for i in yearFilledArray {
            if !yearArray.contains(i) {
                coursesGrouped[i] = [Course]()
            }
        }
        
        let sortedYourArray = coursesGrouped.sorted( by: { $0.0 > $1.0 })
        courseGrouped = sortedYourArray
        
        
        print(courseGrouped[1].value.isEmpty)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Grouping course by year
        groupingCourse()
        
        // Register tableview cell and header
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return courseGrouped.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return courseGrouped[section].value.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.text = courseGrouped[section].key.description
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        if courseGrouped[section].value.isEmpty {
            label.frame = CGRect.init(x: 15, y: 5, width: 50, height: headerView.frame.height-25)
            label.font = .boldSystemFont(ofSize: 12)
            label.backgroundColor = UIColor.systemGray5
            label.textColor = UIColor.darkGray
            
        } else {
            label.frame = CGRect.init(x: 10.0, y: 5, width: 60, height: headerView.frame.height-20)
            label.font = .boldSystemFont(ofSize: 14)
            label.backgroundColor = #colorLiteral(red: 0.9943941236, green: 0.9069606066, blue: 0.9247472882, alpha: 1)
            label.textColor = .black
        }
        
        headerView.addSubview(label)
        
        let linePath = UIBezierPath()
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        if section == 0 {
            startPoint = CGPoint(x: offsetTimeline, y: 25)
        } else {
            startPoint = CGPoint(x: offsetTimeline, y: 0)
        }
        
        endPoint = CGPoint(x: offsetTimeline, y: 45)
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
        
        let courseData = courseGrouped[indexPath.section].value[indexPath.row]
        
        // Underline style
        let attributedCourseString = NSMutableAttributedString.init(string: courseData.typeCertificate ?? "")
        attributedCourseString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedCourseString.length))
        cell.typeCertificateLabel.attributedText = attributedCourseString
        
        // Bold style
        cell.courseNameLabel.font = UIFont.boldSystemFont(ofSize: cell.courseNameLabel.font.pointSize)
        cell.courseNameLabel.text = courseData.courseName
        
        // Gray color
        cell.dateAwardedLabel.textColor = UIColor.darkGray
        cell.dateAwardedLabel.text = "Awarded on: \(courseData.dateAwarded?.toString() ?? "")"

        return cell
    }
    
}
