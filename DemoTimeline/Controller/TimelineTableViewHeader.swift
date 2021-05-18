//
//  TimelineTableViewHeader.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import UIKit

class TimelineTableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 5
    }
    
}
