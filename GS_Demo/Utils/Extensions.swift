//
//  Extensions.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 21/07/22.
//
import Foundation

extension Date {
    func getDateString(format: String = "YYYY-MM-DD") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension String {
    func getDate(format: String = "YYYY-MM-DD") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
