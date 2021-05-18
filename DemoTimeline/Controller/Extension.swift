//
//  Extension.swift
//  DemoTimeline
//
//  Created by Fereizqo Sulaiman on 18/05/21.
//

import Foundation

extension Date {
    static func dateFromCustomString(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: stringDate) ?? Date()
    }
    
//    static func stringFromCustomDate(date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        return dateFormatter.string(from: self)
//    }
    
    func toString(format: String = "dd-MM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var year: Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year ?? 2021
    }
}
