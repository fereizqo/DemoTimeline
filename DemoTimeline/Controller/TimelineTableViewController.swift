//
//  TimelineTableViewController.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    let offsetTimeline: CGFloat = 40.0
    let labelTimelineWidthFilled: CGFloat = 60.0
    let labelTimelineWidthEmpty: CGFloat = 50.0
    
    let sectionHeaderHeight: CGFloat = 50.0
    let labelTimelineHeightFilled: CGFloat = 30.0
    let labelTimelineHeightEmpty: CGFloat = 25.0
    
    var courseGrouped = [Dictionary<Int, [Course]>.Element]()
    
    let courseArray = [
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "15/02/1997"), courseName: "Computer Course", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "15/10/2020"), courseName: "Swift Course 3", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/08/2020"), courseName: "Swift Course 2", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "15/06/2020"), courseName: "Swift Course 1", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/08/2014"), courseName: "Python Course", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/06/2018"), courseName: "C# Course 1", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "03/08/2018"), courseName: "C# Course 2", typeCertificate: "Certificate of Completion"),
        Course(dateAwarded: Date.dateFromCustomString(stringDate: "15/02/2008"), courseName: "Microsoft Office Course", typeCertificate: "Certificate of Completion"),
    ]
    
    fileprivate func groupingCourse() {
        // Sorting course by date
        let sortedCourseArray = courseArray.sorted(by: { $0.dateAwarded > $1.dateAwarded })
        
        // Group course by year
        var coursesGrouped = Dictionary(grouping: sortedCourseArray) { (element) -> Int in
            return element.dateAwarded.year
        }
        
        // Find and fill the gap in the year array
        let yearArray = Array(coursesGrouped.keys)
        guard let maxYear = yearArray.max() , let minYear = yearArray.min() else { return }
        let yearFilledArray = Array(minYear...maxYear)
        
        for i in yearFilledArray {
            if !yearArray.contains(i) {
                coursesGrouped[i] = [Course]()
            }
        }
        
        // Sorting course by year
        let sortedYourArray = coursesGrouped.sorted( by: { $0.0 > $1.0 })
        courseGrouped = sortedYourArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Grouping course by year
        groupingCourse()
        
        // TableView appeareances
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        // Register tableview cell
        let testTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(testTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return courseGrouped.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return courseGrouped[section].value.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Return the height of header sectionn
        return sectionHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create header view
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: sectionHeaderHeight))
//        headerView.backgroundColor = .brown
        
        // Create year label
        let label = UILabel()
        label.text = courseGrouped[section].key.description
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        if courseGrouped[section].value.isEmpty {
            // Year label style without course data
            label.frame = CGRect.init(x: offsetTimeline - (0.5*labelTimelineWidthEmpty),
                                      y: (sectionHeaderHeight - labelTimelineHeightEmpty)*0.5,
                                      width: labelTimelineWidthEmpty,
                                      height: labelTimelineHeightEmpty)
            label.font = .boldSystemFont(ofSize: 12)
            label.backgroundColor = UIColor.systemGray5
            label.textColor = UIColor.darkGray
        } else {
            // Year label style with course data
            label.frame = CGRect.init(x: offsetTimeline - (0.5*labelTimelineWidthFilled),
                                      y: (sectionHeaderHeight - labelTimelineHeightFilled)*0.5,
                                      width: labelTimelineWidthFilled,
                                      height: labelTimelineHeightFilled)
            label.font = .boldSystemFont(ofSize: 14)
            label.backgroundColor = #colorLiteral(red: 0.9943941236, green: 0.9069606066, blue: 0.9247472882, alpha: 1)
            label.textColor = .black
        }
        
        // Add label to header view
        headerView.addSubview(label)
        
        // Create line for the timeline
        let linePath = UIBezierPath()
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        if section == 0 {
            // The line start position at first section
            startPoint = CGPoint(x: offsetTimeline, y: 0.5*sectionHeaderHeight)
        } else {
            // The line start position at other section
            startPoint = CGPoint(x: offsetTimeline, y: -(0.5*sectionHeaderHeight))
        }
        
        // The line end position
        endPoint = CGPoint(x: offsetTimeline, y: sectionHeaderHeight)
        
        // Create the line path
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        //  Create layer for line path
        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = 2.0
        lineLayer.lineCap = .butt
        lineLayer.strokeColor = UIColor.systemGray2.cgColor
        
        // Add line to header view
        headerView.layer.insertSublayer(lineLayer, at: 0)
        
        // Return the view of header section
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineTableViewCell", for: indexPath) as? TimelineTableViewCell else { return UITableViewCell()}
        
        // Pass data into tableView cell
        cell.allRows = courseGrouped[courseGrouped.count-1].value.count
        cell.allSection = courseGrouped.count
        cell.currentIndexPath = indexPath
        cell.setNeedsDisplay()
        
        // Config cell
        let courseData = courseGrouped[indexPath.section].value[indexPath.row]
        cell.configure(typeCertificate: courseData.typeCertificate, courseName: courseData.courseName, dateAwarded: courseData.dateAwarded)
        
        // Return cell for row
        return cell
    }

}
