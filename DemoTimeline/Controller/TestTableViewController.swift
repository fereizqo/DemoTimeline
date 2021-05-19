//
//  TestTableViewController.swift
//  TestTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    let offsetTimeline = 40.0
    let testArray = [2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018, 2020, 2019, 2018]
    
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
    
    var courseGrouped = [Dictionary<Int, [Course]>.Element]()
    
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
        let testTableViewCellNib = UINib(nibName: "TestTableViewCell", bundle: Bundle(for: TestTableViewCell.self))
        self.tableView.register(testTableViewCellNib, forCellReuseIdentifier: "TestTableViewCell")
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
        return 45
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        // Create year label
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
        
        // Create line for the timeline
        let linePath = UIBezierPath()
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        if section == 0 {
            startPoint = CGPoint(x: offsetTimeline, y: 25)
        } else {
            startPoint = CGPoint(x: offsetTimeline, y: -25)
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell", for: indexPath) as? TestTableViewCell else { return UITableViewCell()}
        
        cell.allRows = courseGrouped[courseGrouped.count-1].value.count
        cell.allSection = courseGrouped.count
        cell.currentIndexPath = indexPath
        cell.setNeedsDisplay()
        let courseData = courseGrouped[indexPath.section].value[indexPath.row]
        cell.configure(typeCertificate: courseData.typeCertificate, courseName: courseData.courseName, dateAwarded: courseData.dateAwarded)
        
        return cell
    }

}
