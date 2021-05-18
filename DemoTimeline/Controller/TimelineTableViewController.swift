//
//  TimelineTableViewController.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    
    let testArray = [2020, 2019, 2018]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timelineTableViewCellNib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle(for: TimelineTableViewCell.self))
        self.tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "TimelineTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return testArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20.0, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "Title"
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

        return cell
    }
    
    func createLine(path: UIBezierPath) {
        
    }
}
